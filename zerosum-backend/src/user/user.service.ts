import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { JsonRpcProvider, Wallet, ethers } from 'ethers';
import { supportedChainResources } from 'src/utils/typeorm/entities/resource';
import { supportedChainStats } from 'src/utils/typeorm/entities/stats';
import { MantaStats } from 'src/utils/typeorm/entities/stats/manta.stats';
import { Users } from 'src/utils/typeorm/entities/users.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(Users)
    private readonly usersRepository: Repository<Users>,
    @InjectRepository(MantaStats)
    private readonly mantaStatsRepository: Repository<MantaStats>,
  ) {}

  async handleSignIn(
    uuid: string,
    accessToken: string,
    username: string,
  ): Promise<void> {
    try {
      const user: Users = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });

      const date: Date = new Date();

      user
        ? await this.usersRepository
            .createQueryBuilder()
            .update()
            .set({
              accessToken: accessToken,
              username: username,
              lastLogin: date.getTime(),
            })
            .where('uuid = :uuid', { uuid: uuid })
            .execute()
        : await this.usersRepository.save({
            uuid: uuid,
            accessToken: accessToken,
            username: username,
            lastLogin: date.getTime(),
            pendingMints: [],
            referrals: [],
          });
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  }

  async registerAddress(
    uuid: string,
    address: string,
    message: string,
    signature: string,
  ) {
    try {
      this._validateAddressAndSignature(address, message, signature);

      // Check if the address is already linked to another user
      const existingAddress = await this.usersRepository.findOne({
        where: { address },
      });

      if (existingAddress)
        throw new BadRequestException('Address already linked');

      // Retrieve the user
      const user: Users = await this.usersRepository.findOne({
        where: { uuid },
      });

      if (!user) throw new BadRequestException('User does not exist');

      // Check if the user already has an address registered
      if (user.address)
        throw new BadRequestException('User already has an address registered');

      await this.usersRepository.manager.transaction(
        async (transactionalEntityManager) => {
          await transactionalEntityManager
            .createQueryBuilder()
            .update(Users)
            .set({ address })
            .where('uuid = :uuid', { uuid })
            .execute();

          Object.values(supportedChainResources).map(async (chainResource) => {
            await transactionalEntityManager
              .createQueryBuilder()
              .insert()
              .into(chainResource)
              .values({
                ownerAddress: address,
                astralite: 0,
                samarium: 0,
                calamarite: 0,
                contractAstralite: 0,
                contractSamarium: 0,
                contractCalamarite: 0,
              })
              .execute();
          });

          Object.values(supportedChainStats).map(async (chainStat) => {
            await transactionalEntityManager
              .createQueryBuilder()
              .insert()
              .into(chainStat)
              .values({
                address: address,
                astraliteAmount: 0,
                astraliteTx: 0,
                samariumAmount: 0,
                samariumTx: 0,
                calamariteAmount: 0,
                calamariteTx: 0,
                faucetUses: 0,
                gasTx: 0,
              })
              .execute();
          });
        },
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async linkUsername(uuid: string): Promise<void> {
    try {
      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      await this.usersRepository.update(uuid, {
        linkedUsername: !user.linkedUsername,
      });
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async addPendingReferral(code: string, uuid: string): Promise<void> {
    try {
      await this.usersRepository.update(uuid, {pendingReferral: code});
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async getUser(uuid: string): Promise<Users & {referralCode: string}> {
    try {
      const user: Users | null = await this.usersRepository.findOne({ where: { uuid: uuid } });
      const referralCode = !user.address ? "" : Buffer.from(user.address.replace('0x', ''), 'hex').toString('base64');

      return {...user, referralCode};
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async getReferral(referralCode: string): Promise<{address: string, messageWithNonce: string, signedMessage: string}> {
    const address = '0x' + (Buffer.from(referralCode, 'base64')).toString('hex');

    const message: string = `Authorized by ZeroSum`;
    const nonce: number = Date.now();
    const messageWithNonce: string = `${message}${nonce}`;
    const messageHash = ethers.solidityPackedKeccak256(["string", "uint"], [message, nonce]);
    const messageBytes = Buffer.from(messageHash.slice(2), 'hex');
    const wallet = new Wallet(process.env.ACCOUNT_PRIVATE_KEY);
    const signedMessage: string = await wallet.signMessage(messageBytes);

    return {address, messageWithNonce, signedMessage};
  }

  private _validateAddressAndSignature(
    address: string,
    message: string,
    signature: string,
  ) {
    try {
      if (!ethers.isAddress(address))
        throw new BadRequestException('Invalid Ethereum address');

      const messageHash = ethers.hashMessage(message);
      const recoveredAddress = ethers.recoverAddress(messageHash, signature);

      const isValidSignature =
        recoveredAddress.toLowerCase() === address.toLowerCase();

      if (!isValidSignature)
        throw new BadRequestException('Invalid Signed Message');
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async useFaucet(uuid: string): Promise<void> {
    try {
      const user: Users = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });

      const date: Date = new Date();
      const oneHour: number = 3_600_000;

      if (user.nextFaucetUse > date.getTime()) {
        throw new BadRequestException('Used faucet recently, wait 1 hour.');
      } else {
        const provider: JsonRpcProvider = new JsonRpcProvider(
          'https://manta-testnet.calderachain.xyz/http',
        );
        const signer: Wallet = new Wallet(
          `${process.env.ACCOUNT_PRIVATE_KEY}`,
          provider,
        );

        const tx = await signer.sendTransaction({
          to: user.address,
          value: ethers.parseEther('0.02'),
        });

        await tx.wait();

        await this.usersRepository
          .createQueryBuilder()
          .update()
          .set({ nextFaucetUse: date.getTime() + oneHour })
          .where('uuid = :uuid', { uuid: uuid })
          .execute();

        await this.mantaStatsRepository
          .createQueryBuilder()
          .update()
          .set({ faucetUses: () => 'faucet_uses + 1' })
          .where('address = :address1 OR address = :address2', {
            address1: '0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1',
            address2: user.address,
          })
          .execute();
      }
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

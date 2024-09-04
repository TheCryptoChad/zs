import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import entities, { Resource, Users } from 'src/utils/typeorm/entities';
import { DataSource, ObjectLiteral, Repository } from 'typeorm';
import { Contract, JsonRpcProvider, Wallet } from 'ethers';
import { resourceABI } from 'src/blockchain/abi/resource.abi';
import { supportedChains } from 'src/utils/chains/chains';
import { supportedChainStats } from 'src/utils/typeorm/entities/stats';
import { supportedChainResources } from 'src/utils/typeorm/entities/resource';
import { MantaResource } from 'src/utils/typeorm/entities/resource/manta.resource';
import migrations from 'src/utils/typeorm/migrations';

@Injectable()
export class ResourceService {
  constructor(
    @InjectRepository(Users)
    private readonly usersRepository: Repository<Users>,
  ) {}

  async getBalances(uuid: string) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      if (!user)
        throw new BadRequestException(
          `User with UUID: ${uuid} could not be found`,
        );

      let resources = await dataSource
        .getRepository(MantaResource)
        .findOne({ where: { ownerAddress: user.address } });
      delete resources.ownerAddress;

      if (
        Object.values(resources).every(
          async (resource) => Number(resource) === 0,
        )
      ) {
        for (
          let i: number = 0;
          i < Object.values(supportedChainResources).length;
          i++
        ) {
          const altResources = await dataSource
            .getRepository(Object.values(supportedChainResources)[i])
            .findOne({ where: { ownerAddress: user.address } });
          delete altResources.ownerAddress;

          if (
            Object.values(altResources).some(
              (altResource) => Number(altResource) > 0,
            )
          ) {
            resources = altResources;
            break;
          }
        }
      }

      Object.values(supportedChainResources).map(async (chainResource) => {
        const altResource = await dataSource
          .getRepository(chainResource)
          .findOne({ where: { ownerAddress: user.address } });
        delete altResource.ownerAddress;

        Object.keys(resources).map((resourceProp) => {
          if (
            Number(resources[resourceProp]) === 0 &&
            Number(altResource[resourceProp]) > 0
          )
            resources[resourceProp] = Number(altResource[resourceProp]);
        });
      });

      if (!resources)
        throw new BadRequestException(
          `Could not find resources for user with address: ${user.address}`,
        );

      return resources;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async getAll(uuid: string) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      if (!user)
        throw new BadRequestException(
          `User with UUID: ${uuid} could not be found`,
        );

      const resources: { [key: number]: Resource } = {};

      await Promise.all(
        Object.entries(supportedChainResources).map(async ([key, value]) => {
          const resource: any = await dataSource
            .getRepository(value)
            .findOne({ where: { ownerAddress: user.address } });
          delete resource.ownerAddress;
          resources[Number(key)] = resource;
        }),
      );

      return resources;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async claimResources(uuid: string, chains: string[]) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      const user: Users = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });

      await this.usersRepository.update(user.uuid, {pendingMints: chains.map(chain => Number(chain))})

      for (let i: number = 0; i < chains.length; i++) {
        const resources = await dataSource
          .getRepository(supportedChainResources[chains[i]])
          .findOne({
            where: { ownerAddress: user.address },
          });

        const { astralite, samarium, calamarite } = resources;

        const astraliteTokenAddress = supportedChains.find(
          (chain) => chain.id === Number(chains[i]),
        ).contracts.astralite;
        const samariumTokenAddress = supportedChains.find(
          (chain) => chain.id === Number(chains[i]),
        ).contracts.samarium;
        const calamariteTokenAddress = supportedChains.find(
          (chain) => chain.id === Number(chains[i]),
        ).contracts.calamarite;

        const provider: JsonRpcProvider = new JsonRpcProvider(
          supportedChains.find(
            (chain) => chain.id === Number(chains[i]),
          ).rpcUrls.default.http[0],
        );
        const signer: Wallet = new Wallet(
          `${process.env.ACCOUNT_PRIVATE_KEY}`,
          provider,
        );
        //signerAddress = 0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1

        const astraliteContract: Contract = new Contract(
          astraliteTokenAddress,
          resourceABI,
          signer,
        );
        const samariumContract: Contract = new Contract(
          samariumTokenAddress,
          resourceABI,
          signer,
        );
        const calamariteContract: Contract = new Contract(
          calamariteTokenAddress,
          resourceABI,
          signer,
        );

        if (astralite > 0) {
          const astraliteTX = await astraliteContract.increaseMintAllowance(
            user.address,
            BigInt(astralite),
          );
          await astraliteTX.wait();
          await dataSource
            .getRepository(supportedChainStats[chains[i]])
            .createQueryBuilder()
            .update()
            .set({ astraliteTx: () => 'astralite_tx + 1' })
            .where('address = :address', {
              address: '0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1',
            })
            .execute();
          await dataSource
            .getRepository(supportedChainResources[chains[i]])
            .update(user.address, {
              astralite: 0,
              contractAstralite: () => `contract_astralite + ${astralite}`,
            });
        }
        if (samarium > 0) {
          const samariumTx = await samariumContract.increaseMintAllowance(
            user.address,
            BigInt(samarium),
          );
          await samariumTx.wait();
          await dataSource
            .getRepository(supportedChainStats[chains[i]])
            .createQueryBuilder()
            .update()
            .set({ samariumTx: () => 'samarium_tx + 1' })
            .where('address = :address', {
              address: '0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1',
            })
            .execute();
          await dataSource
            .getRepository(supportedChainResources[chains[i]])
            .update(user.address, {
              samarium: 0,
              contractSamarium: () => `contract_samarium + ${samarium}`,
            });
        }
        if (calamarite > 0) {
          const calamariteTx = await calamariteContract.increaseMintAllowance(
            user.address,
            BigInt(calamarite),
          );
          await calamariteTx.wait();
          await dataSource
            .getRepository(supportedChainStats[chains[i]])
            .createQueryBuilder()
            .update()
            .set({ calamariteTx: () => 'calamarite_tx + 1' })
            .where('address = :address', {
              address: '0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1',
            })
            .execute();
          await dataSource
            .getRepository(supportedChainResources[chains[i]])
            .update(user.address, {
              calamarite: 0,
              contractCalamarite: () => `contract_calamarite + ${calamarite}`,
            });
        }
      }

      Object.values(supportedChainResources).map(async (chainResource) => {
        await dataSource
          .getRepository(chainResource)
          .update(user.address, { astralite: 0, samarium: 0, calamarite: 0 });
      });
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  }

  async payGas(uuid: string, chain: number) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });

      await dataSource
        .getRepository(supportedChainStats[chain])
        .createQueryBuilder()
        .update()
        .set({ gasTx: () => 'gas_tx + 1' })
        .where('address = :address1 OR address = :address2', {
          address1: '0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1',
          address2: user.address,
        })
        .execute();
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async clearPendingBalances(uuid: string) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();
      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });

      for (
        let i: number = 0;
        i < Object.values(supportedChainResources).length;
        i++
      ) {
        await dataSource
          .getRepository(Object.values(supportedChainResources)[i])
          .update(user.address, {
            contractAstralite: 0,
            contractSamarium: 0,
            contractCalamarite: 0,
          });
      }

      await this.usersRepository.update(uuid, {pendingMints: []});
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

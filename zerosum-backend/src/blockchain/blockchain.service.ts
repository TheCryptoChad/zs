import { Injectable } from '@nestjs/common';
import { resourceABI } from './abi/resource.abi';
import { upgradeABI } from './abi/upgrade.abi';
import { blueprintCollectionABI } from './abi/blueprint-collection.abi';
import { referralABI } from './abi/referral.abi';

@Injectable()
export class BlockchainService {
  constructor() {}

  getAbi() {
    try {
      return {
        erc20Abi: resourceABI,
        erc1155Abi: upgradeABI,
        blueprintCollectionAbi: blueprintCollectionABI,
        referralAbi: referralABI
      };
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

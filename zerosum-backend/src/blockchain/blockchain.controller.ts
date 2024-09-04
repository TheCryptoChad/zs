import { Controller, Get } from '@nestjs/common';
import { BlockchainService } from './blockchain.service';

@Controller('blockchain')
export class BlockchainController {
  constructor(private readonly blockchainService: BlockchainService) {}

  @Get('/get-abi')
  getAbi() {
    try {
      return this.blockchainService.getAbi();
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

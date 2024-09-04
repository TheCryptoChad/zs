import { Controller, Get, Param, Req } from '@nestjs/common';
import { ResourceService } from './resource.service';
import { Request } from 'express';

@Controller('resource')
export class ResourceController {
  constructor(private readonly resourceService: ResourceService) {}

  @Get('/get-balances')
  getBalances(@Req() req: Request) {
    try {
      return this.resourceService.getBalances(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/get-all')
  getAll(@Req() req: Request) {
    try {
      return this.resourceService.getAll(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/claim-resources/:chains')
  async claimResources(@Param('chains') chains: string, @Req() req: Request) {
    try {
      await this.resourceService.claimResources(
        req.user.uuid,
        chains.split('-'),
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/pay-gas/:chain')
  async payGas(@Param('chain') chain: number, @Req() req: Request) {
    try {
      await this.resourceService.payGas(req.user.uuid, chain);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/clear-pending-balances')
  async clearPendingBalances(@Req() req: Request) {
    try {
      await this.resourceService.clearPendingBalances(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

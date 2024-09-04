import {
  Body,
  Controller,
  Get,
  Inject,
  Post,
  Put,
  Query,
  Req,
} from '@nestjs/common';
import { VesselService } from './vessel.service';
import { Request } from 'express';

// NOTE: User is accessible via 'request.user'
@Controller('vessel')
export class VesselController {
  constructor(
    @Inject(VesselService) private readonly vesselService: VesselService,
  ) {}

  @Get('/get-all')
  async getAll(@Req() req: Request) {
    try {
      return await this.vesselService.getAllVessels(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/get')
  async getVessel(@Query() queryParams: { address: string; id: number }) {
    try {
      return await this.vesselService.getVessel(
        queryParams.address.toLowerCase(),
        queryParams.id,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Post('/deploy')
  async deploy(
    @Req() req: Request,
    @Body() body: { vesselId: number; x: number; y: number },
  ) {
    try {
      return await this.vesselService.deploy(
        req.user.uuid,
        body.vesselId,
        body.x,
        body.y,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Put('/move')
  async move(
    @Req() req: Request,
    @Body() body: { address: string; vesselId: number; x: number; y: number },
  ) {
    try {
      return await this.vesselService.move(
        req.user.uuid,
        body.vesselId,
        body.x,
        body.y,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Put('/start-mining')
  async startMining(@Req() req: Request, @Body() body: { vesselId: number }) {
    try {
      return await this.vesselService.startMining(req.user.uuid, body.vesselId);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Put('/finish-mining')
  async finishMining(@Req() req: Request, @Body() body: { vesselId: number }) {
    try {
      return await this.vesselService.finishMining(
        req.user.uuid,
        body.vesselId,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

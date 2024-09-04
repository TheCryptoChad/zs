import { Controller, Get, Query, Req } from '@nestjs/common';
import { Request } from 'express';
import { TileService } from './tile.service';

@Controller('tile')
export class TileController {
  constructor(private readonly tileService: TileService) {}

  @Get('/get-type')
  async determineTileType(
    @Req() req: Request,
    @Query('vesselId') vesselId: string,
  ): Promise<TileTypeData> {
    try {
      return await this.tileService.determineTileType(
        req.user.uuid,
        parseInt(vesselId),
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/get-all-exhausted')
  async getExhaustedTilesForUser(
    @Req() req: Request,
  ): Promise<{ uuid: string; x: number; y: number }[]> {
    try {
      return await this.tileService.getExhaustedTilesForUser(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/radar-scan')
  async radarScan(
    @Req() req: Request,
    @Query('vesselId') vesselId: string,
  ): Promise<{ type: number; x: number; y: number }[]> {
    try {
      return await this.tileService.radarScan(req.user.uuid, Number(vesselId));
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

import { Module } from '@nestjs/common';
import { VesselController } from './vessel.controller';
import { VesselService } from './vessel.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Vessel } from '../utils/typeorm/entities/vessel.entity';
import { ExhaustedTile, Resource, Users } from 'src/utils/typeorm/entities';
import { TileService } from 'src/tile/tile.service';
import { RandomSeed } from 'src/utils/typeorm/entities/random-seed.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Vessel,
      Resource,
      Users,
      RandomSeed,
      ExhaustedTile,
    ]),
  ],
  controllers: [VesselController],
  providers: [VesselService, TileService],
})
export class VesselModule {}

import { Module } from '@nestjs/common';
import { TileService } from './tile.service';
import { TileController } from './tile.controller';
import { RandomSeed } from 'src/utils/typeorm/entities/random-seed.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ExhaustedTile, Vessel, Users } from 'src/utils/typeorm/entities';

@Module({
  imports: [TypeOrmModule.forFeature([RandomSeed, ExhaustedTile, Vessel, Users])],
  controllers: [TileController],
  providers: [TileService],
  exports: [TileService],
})
export class TileModule {}

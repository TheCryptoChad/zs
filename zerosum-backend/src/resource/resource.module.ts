import { Module } from '@nestjs/common';
import { ResourceService } from './resource.service';
import { ResourceController } from './resource.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import {
  ExhaustedTile,
  Vessel,
  Users,
} from 'src/utils/typeorm/entities';
import { supportedChainResources } from 'src/utils/typeorm/entities/resource';
import { supportedChainStats } from 'src/utils/typeorm/entities/stats';

@Module({
  imports: [TypeOrmModule.forFeature([Users, Vessel, ExhaustedTile, ...Object.values(supportedChainStats), ...Object.values(supportedChainResources)])],
  controllers: [ResourceController],
  providers: [ResourceService],
})
export class ResourceModule {}

import { Module } from '@nestjs/common';
import { StatsService } from './stats.service';
import { StatsController } from './stats.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Users, Stats, LoginTracker } from 'src/utils/typeorm/entities';

@Module({
  imports: [TypeOrmModule.forFeature([Users, Stats, LoginTracker])],
  controllers: [StatsController],
  providers: [StatsService],
})
export class StatsModule {}

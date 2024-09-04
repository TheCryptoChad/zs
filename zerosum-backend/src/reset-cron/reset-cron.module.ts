import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import {
  ExhaustedTile,
  LoginTracker,
  RandomSeed,
  Users,
} from 'src/utils/typeorm/entities';
import { ResetCronService } from './reset-cron.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([RandomSeed, ExhaustedTile, LoginTracker, Users]),
  ],
  providers: [ResetCronService],
  exports: [ResetCronService],
})
export class ResetCronModule {}

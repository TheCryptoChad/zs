import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Users } from 'src/utils/typeorm/entities/users.entity';
import { UserService } from 'src/user/user.service';
import { Resource, MantaStats } from 'src/utils/typeorm/entities';

@Module({
  imports: [TypeOrmModule.forFeature([Users, Resource, MantaStats]), HttpModule],
  controllers: [AuthController],
  providers: [AuthService, UserService],
})
export class AuthModule {}

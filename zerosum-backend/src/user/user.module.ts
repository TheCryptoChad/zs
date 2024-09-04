import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Users } from 'src/utils/typeorm/entities/users.entity';
import { supportedChainResources } from 'src/utils/typeorm/entities/resource';
import { supportedChainStats } from 'src/utils/typeorm/entities/stats';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Users,
      ...Object.values(supportedChainStats),
      ...Object.values(supportedChainResources),
    ]),
  ],
  controllers: [UserController],
  providers: [UserService],
})
export class UserModule {}

import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { HttpModule } from '@nestjs/axios';
import { UserModule } from './user/user.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TypeOrmConfigService } from './utils/typeorm/data-source';
import { VesselModule } from './vessel/vessel.module';
import { DataSource } from 'typeorm';
import { JwtMiddleware } from './middleware/jwt.middleware';
import { ResourceModule } from './resource/resource.module';
import { TileModule } from './tile/tile.module';
import { ScheduleModule } from '@nestjs/schedule';
import { ResetCronModule } from './reset-cron/reset-cron.module';
import { StatsModule } from './stats/stats.module';
import { BlockchainModule } from './blockchain/blockchain.module';
import { UpdateModule } from './update/update.module';

@Module({
  imports: [
    ConfigModule.forRoot({}),
    ScheduleModule.forRoot(),
    AuthModule,
    BlockchainModule,
    HttpModule,
    UserModule,
    VesselModule,
    TypeOrmModule.forRootAsync({
      useClass: TypeOrmConfigService,
      dataSourceFactory: async (options) => {
        try {
          const dataSource = await new DataSource(options).initialize();
          await dataSource.runMigrations();
          return dataSource;
        } catch (e) {
          console.error(e);
        }
      },
    }),
    ResourceModule,
    TileModule,
    ResetCronModule,
    StatsModule,
    UpdateModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(JwtMiddleware).exclude('auth/getToken/:code', 'update/get-all').forRoutes('*');
  }
}

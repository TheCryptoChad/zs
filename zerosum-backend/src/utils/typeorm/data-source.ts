import migrations from './migrations';
import entities from './entities';
import { Injectable } from '@nestjs/common';
import { TypeOrmModuleOptions, TypeOrmOptionsFactory } from '@nestjs/typeorm';

@Injectable()
export class TypeOrmConfigService implements TypeOrmOptionsFactory {
  createTypeOrmOptions(): TypeOrmModuleOptions | Promise<TypeOrmModuleOptions> {
    return {
      type: 'postgres',
      host: `${process.env.PGHOST}`,
      port: Number(process.env.PGPORT),
      username: `${process.env.PGUSER}`,
      password: `${process.env.PGPASSWORD}`,
      database: `${process.env.PGDATABASE}`,
      entities: entities,
      migrations: migrations,
    };
  }
}

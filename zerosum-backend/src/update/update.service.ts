import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import entities, { Update } from 'src/utils/typeorm/entities';
import migrations from 'src/utils/typeorm/migrations';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class UpdateService {
  async getAll(): Promise<Update[]> {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      return await dataSource.getRepository(Update).createQueryBuilder().orderBy(`TO_DATE(date, 'DD/MM/YYYY')`, 'DESC').getMany();
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}

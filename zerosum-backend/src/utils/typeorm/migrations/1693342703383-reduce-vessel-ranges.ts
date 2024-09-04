import { DataSource, MigrationInterface, QueryRunner } from 'typeorm';
import migrations from '.';
import entities, { Vessel } from '../entities';

export class ReduceVesselRanges1693342703383 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
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

    const vessels: Vessel[] = await dataSource.getRepository(Vessel).find();

    vessels.map(async (vessel: Vessel) => {
      vessel.range = 1;
      await dataSource.getRepository(Vessel).save(vessel);
    });
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
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

    const vessels: Vessel[] = await dataSource.getRepository(Vessel).find();

    vessels.map(async (vessel: Vessel) => {
      vessel.range = 5;
      await dataSource.getRepository(Vessel).save(vessel);
    });
  }
}

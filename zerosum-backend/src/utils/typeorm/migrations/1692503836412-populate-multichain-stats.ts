import { DataSource, MigrationInterface, QueryRunner } from 'typeorm';
import entities, { BaseStats, MantaStats } from '../entities';
import migrations from '.';

export class PopulateMultichainStats1692503836412
  implements MigrationInterface
{
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

    const mantaStats: MantaStats[] = await dataSource
      .getRepository(MantaStats)
      .find();

    mantaStats.map(async (mantaStat: MantaStats) => {
      const baseStat: BaseStats = new BaseStats();
      baseStat.address = mantaStat.address;
      await dataSource.getRepository(BaseStats).save(baseStat);
    });
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.clearTable('base_stats');
  }
}

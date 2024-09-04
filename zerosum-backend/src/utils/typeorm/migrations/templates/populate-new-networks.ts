import { DataSource, MigrationInterface, QueryRunner } from "typeorm"
import migrations from "..";
import entities from "../../entities";
import { MantaStats } from "../../entities/stats/manta.stats";
import { MantaResource } from "../../entities/resource/manta.resource";

//Import your new table entities
//import { XXXXStats } from "../../entities/stats/xxxx.stats";
//import { XXXXResource } from "../../entities/resource/xxxx.resource";

export class PopulateNewNetworks implements MigrationInterface {

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
            // const baseStat: XXXXStats = new XXXXStats();
            // xxxxStat.address = mantaStat.address;
            // await dataSource.getRepository(XXXXStats).save(xxxxStat);
        });
    
        const mantaResources: MantaResource[] = await dataSource
          .getRepository(MantaResource)
          .find();
    
        mantaResources.map(async (mantaResource: MantaResource) => {
        //   const xxxxResource: XXXXResource = new XXXXResource();
        //   xxxxResource.ownerAddress = mantaResource.ownerAddress;
        //   await dataSource.getRepository(XXXXResource).save(xxxxResource);
        });
      }
    
      public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.clearTable('xxxx_resource');
        await queryRunner.clearTable('xxxx_stats');
      }

}
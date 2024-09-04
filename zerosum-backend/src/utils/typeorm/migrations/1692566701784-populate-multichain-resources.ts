import { DataSource, MigrationInterface, QueryRunner } from "typeorm"
import migrations from ".";
import entities from "../entities";
import { BaseResource } from "../entities/resource/base.resource";
import { MantaResource } from "../entities/resource/manta.resource";

export class PopulateMultichainResources1692566701784 implements MigrationInterface {

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
    
        const mantaResources: MantaResource[] = await dataSource
          .getRepository(MantaResource)
          .find();
    
        mantaResources.map(async (mantaResource: MantaResource) => {
          const baseResource: BaseResource = new BaseResource();
          baseResource.ownerAddress = mantaResource.ownerAddress;
          await dataSource.getRepository(BaseResource).save(baseResource);
        });
      }
    
      public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.clearTable('base_resource');
      }

}

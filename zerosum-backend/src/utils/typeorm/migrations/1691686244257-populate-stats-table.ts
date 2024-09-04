import { DataSource, MigrationInterface, QueryRunner } from "typeorm"
import migrations from ".";
import entities, { Users, Stats } from "../entities";

export class PopulateStatsTable1691686244257 implements MigrationInterface {

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
          
          const users: Users[] = await dataSource.getRepository(Users).find();
          
          users.map(async (user: Users) => {
            if(user.address !== null){
                const stat: Stats = new Stats();
                stat.address = user.address;
                await dataSource.getRepository(Stats).save(stat);
            }
          });
          
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.clearTable('stats');
    }

}

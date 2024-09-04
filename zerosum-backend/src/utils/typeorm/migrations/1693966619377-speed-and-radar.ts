import { MigrationInterface, QueryRunner, TableColumn } from "typeorm"

export class SpeedAndRadar1693966619377 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.addColumns('vessel', [
            new TableColumn({
              name: 'speed',
              type: 'bigint',
              isNullable: false,
              default: 0,
            }),
            new TableColumn({
              name: 'radar',
              type: 'bigint',
              isNullable: false,
              default: 0,
            }),
          ]);
        }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.dropColumn('vessel', 'speed');
        await queryRunner.dropColumn('vessel', 'radar');
    }

}

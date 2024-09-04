import { MigrationInterface, QueryRunner, Table, TableColumn } from "typeorm"

export class MultichainResources1692565078318 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('resource', 'manta_resource');
        await queryRunner.changeColumn('manta_resource', 'astralite', new TableColumn({
            name: 'astralite',
            type: 'bigint',
            isNullable: false,
            default: 0
        }));
        await queryRunner.changeColumn('manta_resource', 'samarium', new TableColumn({
            name: 'samarium',
            type: 'bigint',
            isNullable: false,
            default: 0
        }));
        await queryRunner.changeColumn('manta_resource', 'calamarite', new TableColumn({
            name: 'calamarite',
            type: 'bigint',
            isNullable: false,
            default: 0
        }));
        await queryRunner.createTable(
            new Table({
              name: 'base_resource',
              columns: [
                {
                  name: 'owner_address',
                  type: 'varchar',
                  isPrimary: true,
                  isNullable: false,
                },
                {
                  name: 'astralite',
                  type: 'bigint',
                  isNullable: false,
                  default: 0,
                },
                {
                  name: 'samarium',
                  type: 'bigint',
                  isNullable: false,
                  default: 0,
                },
                {
                  name: 'calamarite',
                  type: 'bigint',
                  isNullable: false,
                  default: 0,
                },
                {
                  name: 'contract_astralite',
                  type: 'bigint',
                  isNullable: false,
                  default: 0,
                },
                {
                  name: 'contract_samarium',
                  type: 'bigint',
                  isNullable: false,
                  default: 0,
                },
                {
                  name: 'contract_calamarite',
                  type: 'bigint',
                  isNullable: false,
                  default: 0,
                },
              ],
            }),
          );
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.dropTable('base_resource');
        await queryRunner.changeColumn('manta_resource', 'astralite', new TableColumn({
            name: 'astralite',
            type: 'bigint',
            isNullable: false
        }));
        await queryRunner.changeColumn('manta_resource', 'samarium', new TableColumn({
            name: 'samarium',
            type: 'bigint',
            isNullable: false
        }));
        await queryRunner.changeColumn('manta_resource', 'calamarite', new TableColumn({
            name: 'calamarite',
            type: 'bigint',
            isNullable: false
        }));
        await queryRunner.renameTable('manta_resource', 'resource');
    }

}

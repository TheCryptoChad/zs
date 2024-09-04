import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class MultichainStats1692499477362 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameTable('stats', 'manta_stats');
    await queryRunner.createTable(
      new Table({
        name: 'base_stats',
        columns: [
          {
            name: 'address',
            type: 'varchar',
            isPrimary: true,
            isNullable: false,
          },
          {
            name: 'astralite_amount',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'astralite_tx',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'samarium_amount',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'samarium_tx',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'calamarite_amount',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'calamarite_tx',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'faucet_uses',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
          {
            name: 'gas_tx',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
        ],
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('base_stats');
    await queryRunner.renameTable('manta_stats', 'stats');
  }
}

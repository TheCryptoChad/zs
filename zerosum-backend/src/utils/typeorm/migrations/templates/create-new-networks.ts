import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateNewNetworks implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'xxxx_stats',
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

    await queryRunner.createTable(
      new Table({
        name: 'xxxx_resource',
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
    await queryRunner.dropTable('xxxx_resource');
    await queryRunner.dropTable('xxxx_stats');
  }
}
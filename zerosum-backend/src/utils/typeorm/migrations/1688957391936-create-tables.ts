import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateTables1688957391936 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'users',
        columns: [
          {
            name: 'uuid',
            type: 'varchar',
            isPrimary: true,
            isNullable: false,
          },
          {
            name: 'access_token',
            type: 'varchar',
            isNullable: false,
          },
          {
            name: 'address',
            type: 'varchar',
            isNullable: true,
          },
        ],
      }),
    );

    await queryRunner.createTable(
      new Table({
        name: 'blockchain',
        columns: [
          {
            name: 'name',
            type: 'varchar',
            isPrimary: true,
            isNullable: false,
          },
          {
            name: 'latest_block',
            type: 'bigint',
            isNullable: false,
          },
          {
            name: 'updated_at',
            type: 'bigint',
            isNullable: false,
          },
        ],
      }),
    );

    await queryRunner.createTable(
      new Table({
        name: 'ship',
        columns: [
          {
            name: 'id',
            type: 'bigint',
            isPrimary: true,
            isNullable: false,
          },
          {
            name: 'owner_address',
            type: 'varchar',
            isNullable: false,
          },
          {
            name: 'range',
            type: 'bigint',
            isNullable: false,
          },
          {
            name: 'x',
            type: 'bigint',
            isNullable: true,
            default: null,
          },
          {
            name: 'y',
            type: 'bigint',
            isNullable: true,
            default: null,
          },
          {
            name: 'mining_end_time',
            type: 'bigint',
            isNullable: true,
            default: null,
          },
          {
            name: 'is_locked',
            type: 'boolean',
            default: false,
          },
        ],
      }),
    );

    await queryRunner.createTable(
      new Table({
        name: 'resource',
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
          },
          {
            name: 'samarium',
            type: 'bigint',
            isNullable: false,
          },
          {
            name: 'calamarite',
            type: 'bigint',
            isNullable: false,
          },
        ],
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('resource');
    await queryRunner.dropTable('ship');
    await queryRunner.dropTable('blockchain');
    await queryRunner.dropTable('users');
  }
}

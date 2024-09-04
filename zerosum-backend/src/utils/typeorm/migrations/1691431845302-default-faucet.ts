import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class DefaultFaucet1691431845302 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.changeColumn(
      'users',
      'next_faucet_use',
      new TableColumn({
        name: 'next_faucet_use',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.changeColumn(
      'users',
      'next_faucet_use',
      new TableColumn({
        name: 'next_faucet_use',
        type: 'bigint',
        isNullable: true,
      }),
    );
  }
}

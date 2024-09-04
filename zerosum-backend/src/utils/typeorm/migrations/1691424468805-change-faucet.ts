import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class ChangeFaucet1691424468805 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.changeColumn(
      'users',
      'used_faucet',
      new TableColumn({
        name: 'next_faucet_use',
        type: 'bigint',
        isNullable: true,
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.changeColumn(
      'users',
      'next_faucet_use',
      new TableColumn({
        name: 'used_faucet',
        type: 'boolean',
        isNullable: false,
        default: false,
      }),
    );
  }
}

import { MigrationInterface, QueryRunner, Table, TableColumn } from 'typeorm';

export class LoginTracker1694295187030 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'login_tracker',
        columns: [
          {
            name: 'date',
            type: 'bigint',
            isPrimary: true,
            isNullable: false,
          },
          {
            name: 'total_logins',
            type: 'bigint',
            isNullable: false,
            default: 0,
          },
        ],
      }),
    );

    await queryRunner.addColumns('users', [
      new TableColumn({
        name: 'last_login',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
      new TableColumn({
        name: 'total_logins',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
      new TableColumn({
        name: 'consecutive_logins',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
    ]);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('users', 'consecutive_logins');
    await queryRunner.dropColumn('users', 'total_logins');
    await queryRunner.dropColumn('users', 'last_login');
    await queryRunner.dropTable('login_tracker');
  }
}

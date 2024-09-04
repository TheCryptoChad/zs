import { Column, MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class ReferralsTracker1695681579373 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumns('users', [
      new TableColumn({
        name: 'referred_by',
        type: 'varchar',
        isNullable: true,
      }),
      new TableColumn({
        name: 'referrals',
        type: 'varchar',
        isArray: true,
        isNullable: true,
      }),
    ]);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('users', 'referrals');
    await queryRunner.dropColumn('usrers', 'referred_by');
  }
}

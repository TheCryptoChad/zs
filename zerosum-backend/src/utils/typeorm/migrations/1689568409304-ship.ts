import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class Ship1689568409304 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'ship',
      new TableColumn({
        name: 'name',
        type: 'varchar',
        isNullable: true,
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('ship', 'name');
  }
}

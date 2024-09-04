import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class ShipModel1690203741707 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'ship',
      new TableColumn({
        name: 'model',
        type: 'varchar',
        isNullable: true,
        default: null,
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('ship', 'model');
  }
}

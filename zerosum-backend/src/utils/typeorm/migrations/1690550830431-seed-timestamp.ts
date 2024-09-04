import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class SeedTimestamp1690550830431 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'random_seed',
      new TableColumn({
        name: 'generated_at',
        type: 'bigint',
        isNullable: true,
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('random_seed', 'generated_at');
  }
}

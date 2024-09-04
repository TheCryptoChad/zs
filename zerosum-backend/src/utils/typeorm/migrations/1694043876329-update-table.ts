import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class UpdateTable1694043876329 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'update',
        columns: [
          {
            name: 'version',
            type: 'varchar',
            isPrimary: true,
            isNullable: false,
          },
          {
            name: 'title',
            type: 'varchar',
            isNullable: false,
          },
          {
            name: 'changes',
            type: 'varchar',
            isNullable: false,
          },
          {
            name: 'date',
            type: 'varchar',
            isNullable: false,
          },
        ],
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('update');
  }
}

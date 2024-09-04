import { MigrationInterface, QueryRunner, Table, TableColumn } from 'typeorm';

export class RefreshingTilesAndRandomness1690157470732
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumns('ship', [
      new TableColumn({
        name: 'pending_astralite',
        type: 'bigint',
        isNullable: true,
        default: null,
      }),
      new TableColumn({
        name: 'pending_samarium',
        type: 'bigint',
        isNullable: true,
        default: null,
      }),
      new TableColumn({
        name: 'pending_calamarite',
        type: 'bigint',
        isNullable: true,
        default: null,
      }),
    ]);

    await queryRunner.createTable(
      new Table({
        name: 'exhausted_tile',
        columns: [
          {
            name: 'id',
            type: 'bigint',
            isPrimary: true,
            isGenerated: true,
            generationStrategy: 'increment',
            isNullable: false,
          },
          {
            name: 'uuid',
            type: 'varchar',
          },
          {
            name: 'x',
            type: 'bigint',
          },
          {
            name: 'y',
            type: 'bigint',
          },
        ],
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('exhausted_tile');
    await queryRunner.dropColumn('ship', 'pending_calamarite');
    await queryRunner.dropColumn('ship', 'pending_samarium');
    await queryRunner.dropColumn('ship', 'pending_astralite');
  }
}

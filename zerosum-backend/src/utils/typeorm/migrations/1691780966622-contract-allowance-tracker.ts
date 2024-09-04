import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class ContractAllowanceTracker1691780966622
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumns('resource', [
      new TableColumn({
        name: 'contract_astralite',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
      new TableColumn({
        name: 'contract_samarium',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
      new TableColumn({
        name: 'contract_calamarite',
        type: 'bigint',
        isNullable: false,
        default: 0,
      }),
    ]);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('resource', 'contract_astralite');
    await queryRunner.dropColumn('resource', 'contract_samarium');
    await queryRunner.dropColumn('resource', 'contract_calamarite');
  }
}

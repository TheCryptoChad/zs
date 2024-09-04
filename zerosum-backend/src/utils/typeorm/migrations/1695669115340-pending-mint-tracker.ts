import { MigrationInterface, QueryRunner, TableColumn } from "typeorm"

export class PendingMintTracker1695669115340 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.addColumn('users', 
            new TableColumn({
              name: 'pending_mints',
              type: 'bigint',
              isArray: true,
              isNullable: true,
            }),
        );
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.dropColumn('users', 'pending_mints');
    }

}

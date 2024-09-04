import { MigrationInterface, QueryRunner } from "typeorm"

export class ChangeShipToVessel1692050237598 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('ship', 'vessel');
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('vessel', 'ship');
    }

}

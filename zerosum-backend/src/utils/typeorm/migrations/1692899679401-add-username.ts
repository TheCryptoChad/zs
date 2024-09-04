import { MigrationInterface, QueryRunner, TableColumn } from "typeorm"

export class AddUsername1692899679401 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.addColumns(
        'users',
            [
            new TableColumn({
                name: 'username',
                type: 'varchar',
                isNullable: true,
            }),
            new TableColumn({
                name: 'linked_username',
                type: 'boolean',
                isNullable: false,
                default: false
            }),
            ]
        );
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.dropColumn('users', 'linked_username');
        await queryRunner.dropColumn('users', 'username');
    }
}

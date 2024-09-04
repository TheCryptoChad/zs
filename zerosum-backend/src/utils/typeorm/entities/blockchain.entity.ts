import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class Blockchain {
  @PrimaryColumn({ name: 'name', type: 'varchar' })
  name: string;

  @Column({ name: 'latest_block', type: 'bigint' })
  latestBlock: number;

  @Column({ name: 'updated_at', type: 'bigint' })
  updatedAt: number;
}

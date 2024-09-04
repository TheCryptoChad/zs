import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class Update {
  @PrimaryColumn({ name: 'version', type: 'varchar', nullable: false })
  version: string;

  @Column({ name: 'title', type: 'varchar', nullable: false })
  title: string;

  @Column({ name: 'changes', type: 'varchar', nullable: false })
  changes: string;

  @Column({ name: 'date', type: 'varchar', nullable: false })
  date: string;
}

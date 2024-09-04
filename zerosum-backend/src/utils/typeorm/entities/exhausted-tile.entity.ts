import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ExhaustedTile {
  @PrimaryGeneratedColumn({ name: 'id', type: 'bigint' })
  id: number;

  @Column({ name: 'uuid', type: 'varchar' })
  uuid: string;

  @Column({ name: 'x', type: 'bigint' })
  x: number;

  @Column({ name: 'y', type: 'bigint' })
  y: number;
}

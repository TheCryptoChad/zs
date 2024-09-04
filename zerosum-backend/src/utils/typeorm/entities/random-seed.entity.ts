import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class RandomSeed {
  @PrimaryGeneratedColumn({ name: 'id', type: 'bigint' })
  id: number;

  @Column({ name: 'seed', type: 'bigint' })
  seed: number;

  @Column({ name: 'generated_at', type: 'bigint', nullable: true })
  generatedAt: number;
}

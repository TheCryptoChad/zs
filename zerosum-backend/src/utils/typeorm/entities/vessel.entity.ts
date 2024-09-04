import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class Vessel {
  @PrimaryColumn({ name: 'id', type: 'bigint' })
  id: number;

  @Column({ name: 'owner_address', type: 'varchar' })
  ownerAddress: string;

  @Column({ name: 'range', type: 'bigint', default: 1 })
  range: number;

  @Column({ name: 'x', type: 'bigint', nullable: true, default: null })
  x: number;

  @Column({ name: 'y', type: 'bigint', nullable: true, default: null })
  y: number;

  @Column({
    name: 'mining_end_time',
    type: 'bigint',
    nullable: true,
    default: null,
  })
  miningEndTime: number;

  @Column({ name: 'is_locked', type: 'boolean', default: false })
  isLocked: boolean;

  @Column({ name: 'name', type: 'varchar', nullable: true })
  name: string;

  @Column({
    name: 'pending_astralite',
    type: 'bigint',
    nullable: true,
    default: null,
  })
  pendingAstralite: number;

  @Column({
    name: 'pending_samarium',
    type: 'bigint',
    nullable: true,
    default: null,
  })
  pendingSamarium: number;

  @Column({
    name: 'pending_calamarite',
    type: 'bigint',
    nullable: true,
    default: null,
  })
  pendingCalamarite: number;

  @Column({ name: 'model', type: 'varchar', nullable: true, default: null })
  model: string;

  @Column({ name: 'speed', type: 'bigint', default: 0 })
  speed: number;

  @Column({ name: 'radar', type: 'bigint', default: 0 })
  radar: number;
}

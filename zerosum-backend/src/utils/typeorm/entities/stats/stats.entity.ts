import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class Stats {
  @PrimaryColumn({ name: 'address', type: 'varchar' })
  address: string;

  @Column({ name: 'astralite_amount', type: 'bigint' })
  astraliteAmount: number;

  @Column({ name: 'astralite_tx', type: 'bigint' })
  astraliteTx: number;

  @Column({ name: 'samarium_amount', type: 'bigint' })
  samariumAmount: number;

  @Column({ name: 'samarium_tx', type: 'bigint' })
  samariumTx: number;

  @Column({ name: 'calamarite_amount', type: 'bigint' })
  calamariteAmount: number;

  @Column({ name: 'calamarite_tx', type: 'bigint' })
  calamariteTx: number;

  @Column({ name: 'faucet_uses', type: 'bigint' })
  faucetUses: number;

  @Column({ name: 'gas_tx', type: 'bigint' })
  gasTx: number;
}
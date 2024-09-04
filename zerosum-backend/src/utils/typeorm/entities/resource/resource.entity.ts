import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class Resource {
  @PrimaryColumn({ name: 'owner_address', type: 'varchar' })
  ownerAddress: string;

  @Column({ name: 'astralite', type: 'bigint' })
  astralite: number;

  @Column({ name: 'samarium', type: 'bigint' })
  samarium: number;

  @Column({ name: 'calamarite', type: 'bigint' })
  calamarite: number;

  @Column({ name: 'contract_astralite', type: 'bigint' })
  contractAstralite: number;

  @Column({ name: 'contract_samarium', type: 'bigint' })
  contractSamarium: number;

  @Column({ name: 'contract_calamarite', type: 'bigint' })
  contractCalamarite: number;
}

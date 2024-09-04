import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class Users {
  @PrimaryColumn({ name: 'uuid', type: 'varchar' })
  uuid: string;

  @Column({ name: 'access_token', type: 'varchar', select: false })
  accessToken: string;

  @Column({ name: 'address', type: 'varchar' })
  address: string;

  @Column({ name: 'next_faucet_use', type: 'bigint' })
  nextFaucetUse: number;

  @Column({ name: 'username', type: 'varchar' })
  username: string;

  @Column({ name: 'linked_username', type: 'boolean' })
  linkedUsername: boolean;

  @Column({ name: 'last_login', type: 'bigint' })
  lastLogin: number;

  @Column({ name: 'total_logins', type: 'bigint' })
  totalLogins: number;

  @Column({ name: 'consecutive_logins', type: 'bigint' })
  consecutiveLogins: number;

  @Column({ name: 'pending_mints', type: 'bigint', array: true, nullable: true })
  pendingMints: number[];

  @Column({ name: 'referred_by', type: 'varchar',  nullable: true })
  referredBy: string;

  @Column({ name: 'referrals', type: 'varchar', array: true, nullable: true })
  referrals: string[];

  @Column({ name: 'pending_referral', type: 'varchar',  nullable: true })
  pendingReferral: string;
}

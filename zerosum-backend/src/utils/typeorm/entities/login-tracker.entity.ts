import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity()
export class LoginTracker {
  @PrimaryColumn({ name: 'date', type: 'bigint' })
  date: number;

  @Column({ name: 'total_logins', type: 'bigint' })
  totalLogins: number;
}

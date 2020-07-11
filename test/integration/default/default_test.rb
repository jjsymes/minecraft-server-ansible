describe service('minecraft') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe service('bedrock') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe crontab(path: '/etc/cron.d/minecraft-backup') do
  its('commands') { should include '/opt/minecraftserver/minecraft_backup.sh /opt/minecraftserver/minecraft minecraft.service' }
  its('minutes') { should cmp '0' }
  its('hours') { should cmp '04' }
  its('days') { should cmp '*' }
  its('user') { should include 'minecraft'}
end

describe crontab(path: '/etc/cron.d/minecraft-backup-cleanup') do
  its('commands.to_s') { should include '/opt/minecraftserver/minecraft_backup_cleanup.sh' }
  its('minutes') { should cmp '0' }
  its('hours') { should cmp '12' }
  its('days') { should cmp '*' }
  its('user') { should include 'minecraft'}
end

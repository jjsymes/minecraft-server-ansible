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
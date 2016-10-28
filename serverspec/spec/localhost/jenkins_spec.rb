require 'spec_helper'

describe service('jenkins') do
  it { should be_enabled }
  # service jenkins statusが
  # rootしか許可されていないため、コメントアウトをしている
  # /etc/sysconfig/jenkins not readable. Perhaps you forgot 'sudo'?
  #it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

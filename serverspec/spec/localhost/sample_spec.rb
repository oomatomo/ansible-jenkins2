require 'spec_helper'

describe service('jenkins') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8000) do
  it { should be_listening }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

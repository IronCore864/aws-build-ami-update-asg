require 'serverspec'
set :backend, :exec

describe user('helloworld') do
  it { should exist }
end
    
describe port(8080) do
  it { should be_listening }
end

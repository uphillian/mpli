require 'serverspec'

#include Serverspec::Helper::Exec
#include Serverspec::Helper::DetectOS
#
#RSpec.configure do |c|
#  c.before :all do
#    c.path = '/sbin:/usr/sbin'
#  end
#end

describe package('ntp') do
  it { should be_installed }
end

if ['debian','ubuntu'].include?(os[:family])
  describe service('ntp') do
    it { should be_running }
  end
elsif os[:family] == 'redhat'
  describe service('ntpd') do
    it { should be_running }
  end
end

require 'ipaddr'

def getRegion(ip)
  regions = {
    'local'  => IPAddr.new('192.168.0.0/16'),
    'remote' => IPAddr.new('10.0.0.0/8'),
  }

  for zone in regions do
    if regions[zone].include?(ip)
      return zone
    end
  end
  return 'undefined'
end

ip = IPAddr.new(Facter.value('ipaddress'))

Facter.add('region') do
  setcode do
    getRegion(ip)
  end
end

test_name "test for port 80" do
  confine :except, :platform => 'solaris'
  confine :except, :platform => 'windows'
  confine :except, :platform => 'aix'

  hosts.each do |host|
    host.ip
    host.node_name
    assert_equal(true,port_open_within?(host,port=80))
  end
end

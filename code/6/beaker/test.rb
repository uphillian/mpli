test_name "test for httpd" do
  confine :except, :platform => 'solaris'
  confine :except, :platform => 'windows'
  confine :except, :platform => 'aix'

  step "make sure process is running"
  hosts.each do |host|
    restart_command = "bash -c 'systemctl restart httpd'"
    process_count_check = "bash -c '[[ $(ps auxww | grep httpd |wc -l) -gt 1 ]]'"
    on(host, restart_command) { assert_equal(0,exit_code) }
    on(host, restart_command) { assert_equal(0,exit_code) }
    on(host, process_count_check) { assert_equal(0,exit_code) }
  end
end

## Section 2:
### Architecting Puppet for scalability, redundancy and performance

## Puppetserver
  puppetca              192.168.50.100/24
  puppet certificate generate
  lsof / firewalld / iptables

## Load Balancer / PuppetCA 
  puppetca / lb         192.168.50.100/24
    - puppetmaster 1    192.168.50.201/24
    - puppetmaster 2    192.168.50.202/24

webserver: {
  access-log-config: /etc/puppetlabs/puppetserver/request-logging.xml
  client-auth: want
  ssl-host: 0.0.0.0
  ssl-port: 8141
  host: 0.0.0.0
  port: 18140
}

Listen 8140
<VirtualHost *:8140>
  ServerName puppet.example.com
  SSLEngine on
  SSLProtocol -ALL +TLSv1 +TLSv1.1 +TLSv1.2
  SSLCipherSuite ALL:!ADH:RC4+RSA:+HIGH:+MEDIUM:-LOW:-SSLv2:-EXP
  SSLCertificateFile /etc/puppetlabs/puppet/ssl/certs/puppet.example.com.pem
  SSLCertificateKeyFile /etc/puppetlabs/puppet/ssl/private_keys/puppet.example.com.pem
  SSLCertificateChainFile /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem
  SSLCACertificateFile /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem
  # If Apache complains about invalid signatures on the CRL, you can try disabling
  # CRL checking by commenting the next line, but this is not recommended.
  SSLCARevocationFile /etc/puppetlabs/puppet/ssl/ca/ca_crl.pem
  SSLVerifyClient optional
  SSLVerifyDepth 1
  # The `ExportCertData` option is needed for agent certificate expiration warnings
  SSLOptions +StdEnvVars +ExportCertData
  # This header needs to be set if using a loadbalancer or proxy
  RequestHeader unset X-Forwarded-For
  RequestHeader set X-SSL-Subject %{SSL_CLIENT_S_DN}e
  RequestHeader set X-Client-DN %{SSL_CLIENT_S_DN}e
  RequestHeader set X-Client-Verify %{SSL_CLIENT_VERIFY}e
  ProxyPassMatch ^/(puppet-ca/v[123]/.*)$ balancer://puppetca/$1
  ProxyPass / balancer://puppetworker/
  ProxyPassReverse / balancer://puppetworker
  <Proxy balancer://puppetca>
    BalancerMember http://127.0.0.1:18140
  </Proxy>
  <Proxy balancer://puppetworker>
    BalancerMember http://192.168.50.201:18140
    BalancerMember http://192.168.50.202:18140
  </Proxy>
</VirtualHost>



node default {
  notify { "compiled on puppetmaster1": }
}


## Master of Master

## Performance

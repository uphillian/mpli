## Section 3:
### PuppetDB

## Exported Resources / Storeconfigs

## PuppetDB
  puppetca              192.168.50.100/24
  puppetdb              192.168.50.101/24
  postgresql            192.168.50.101/24

## puppetlabs-puppetdb 
 * Quick easy way to configure puppetdb and postgresql
   - Obscures the details

## Postgresql
 * Find latest PostgreSQL you can - get repo rpm for that.

 * Install postgresql repo rpm
   http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-2.noarch.rpm

 * Install postgresql
   yum install postgresql94-server

 * Initialize the database
   postgresql-setup initdb

 * Start the database
   systemctl start postgresql-9.4

## Create puppetdb database
 * Create the User
   sudo -iu postgres
   createuser -DRSP puppetdb

 * Create the Database
   createdb -E UTF8 -O puppetdb_puppetdb

 * Allow access to postgres locally
   /var/lib/pgsql/9.4/data/pg_hba.conf
   local puppetdb puppetdb    md5
   host  puppetdb puppetdb    127.0.0.1/32  md5
   host  puppetdb puppetdb    ::1/128       md5   

 * Restart postgresql
   systemctl restart postgresql-9.4

 * Verify puppetdb user can access postgresql
   psql -h localhost puppetdb_puppetdb
   \d
   \q

## Install and configure puppetdb to use postgresql
 * Edit database.ini, point to local postgresql installation
   /etc/puppetlabs/puppetdb/conf.d/database.ini
   localhost:5432/puppetdb
   username = puppetdb
   password = PacktPub

## Configure Puppetserver to use PuppetDB
 * Tell Puppetserver where to find puppetdb
   /etc/puppetlabs/puppet/puppetdb.conf
   [main]
     server_urls = https://puppetdb.example.com:8081/
     soft_write_failure = false

 * Enabled storeconfigs
   /etc/puppetlabs/puppet/puppet.conf
     storeconfigs = true
     storeconfigs_backend = puppetdb

 * Create routes.yaml
   /etc/puppetlabs/puppet/routes.yaml
     ---
     master:
       facts:
         terminus: puppetdb
         cache: yaml

  * restart puppetserver
    systemctl restart puppetserver
  
  * Verify connectivity to puppetdb
    puppet agent -t
    psql -h localhost puppetdb puppetdb
    \x
    SELECT * from catalogs; 

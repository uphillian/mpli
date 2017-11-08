## Section 3:
### PuppetDB

## Exported Resources / Storeconfigs

## PuppetDB
  puppetca              192.168.50.100/24
  puppetdb              192.168.50.101/24
  postgresql            192.168.50.101/24

## puppetlabs-puppetdb 
 * puppet module install puppetlabs-puppetdb
   https://forge.puppet.com/puppetlabs/puppetdb
 * Quick easy way to configure puppetdb and postgresql
   - Obscures the details

## Postgresql
 * Find latest PostgreSQL you can - get repo rpm for that.

 * Install postgresql repo rpm
   https://yum.postgresql.org
   https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm

 * Install postgresql
   yum install postgresql95-server

 * Initialize the database
   export PATH=$PATH:/usr/pgsql-9.5/bin
   postgresql95-setup initdb

 * Start the database
   systemctl start postgresql-9.5

## Create puppetdb database
 * Create the User
   sudo -iu postgres
   createuser -DRSP puppetdb

 * Create the Database
   createdb -E UTF8 -O puppetdb puppetdb

 * Allow access to postgres locally
   /var/lib/pgsql/9.5/data/pg_hba.conf
   local puppetdb puppetdb    md5
   host  puppetdb puppetdb    127.0.0.1/32  md5
   host  puppetdb puppetdb    ::1/128       md5   

 * Restart postgresql
   systemctl restart postgresql-9.5.service

 * Verify puppetdb user can access postgresql
   psql -h localhost puppetdb puppetdb
   \d
   \q

## Install and configure puppetdb to use postgresql
 * Edit database.ini, point to local postgresql installation
   /etc/puppetlabs/puppetdb/conf.d/database.ini
   localhost:5432/puppetdb
   username = puppetdb
   password = PacktPub

## Enable SSL
   Need certs from puppetca first, run agent on puppetdb node.
   puppetdb ssl-setup

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

## Create exported resource
  * define a resource
   @@host {'exported':
   }
  
  * Export the resource (run puppet agent)

  * Look in the resources table
    \x
    SELECT * from resources where exported = true;

## Collect exported resource
  * mpli client machine, collect on that one using a manifest crafted to do that.

## PuppetDB GUIs
  * Performance Dashboard
  * Panopuppet
  * PuppetExplorer
  * PuppetBoard
  
## PuppetDB APIs
  * Certificate
  * curl
    curl -X GET \
      --tlsv1 --cacert certs/ca.pem \
      --cert certs/thomas.uphill.pem \
      --key private_keys/thomas.uphill.pem \
      https://puppetdb.example.com:8081/pdb/query/v4/

  * Endpoints https://docs.puppet.com/puppetdb/4.1/api/query/v4/entities.html
    - environments
    - resources
    - nodes
    - facts
  * Query https://docs.puppet.com/puppetdb/latest/api/query/tutorial.html
    - environments
    - resources
    - facts
    - nodes



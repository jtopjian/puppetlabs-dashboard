# Puppet Dashboard Module

Gary Larizza <gary@puppetlabs.com>

This module manages and installs the Puppet Dashboard.  It also includes a Puppet Face to manage the Dashboard/Console programmatically or from the CLI

# Quick Start

To install the Puppet Dashboard and configure it with sane defaults, include the following in your site.pp file:

MySQL on the same server:

    node default {
      class {'mysql::server': }
      class { 'dashboard::db::mysql':
        db_name     => 'puppet_dashboard',
        db_user     => 'puppet-dbuser',
        db_password => 'changeme',
        client_host => 'localhost',
      }
      class {'apache': }
      class {'dashboard':
        dashboard_ensure          => 'present',
        dashboard_user            => 'puppet-dbuser',
        dashboard_group           => 'puppet-dbgroup',
        dashboard_password        => 'changeme',
        dashboard_db              => 'dashboard_prod',
        dashboard_site            => $fqdn,
        dashboard_port            => '8080',
        passenger                 => true,
      }
    }
    
MySQL on another server:

    node db_server {
      class {'mysql::server': }
      class { 'dashboard::db::mysql':
        db_name     => 'puppet_dashboard',
        db_user     => 'puppet-dbuser',
        db_password => 'changeme',
        client_host => 'dashboard',
      }
    }

    node dashboard {
      class {'mysql': }
      class {'apache': }
      class {'dashboard':
        dashboard_ensure          => 'present',
        dashboard_user            => 'puppet-dbuser',
        dashboard_group           => 'puppet-dbgroup',
        dashboard_password        => 'changeme',
        dashboard_db_host         => 'db.example.com',
        dashboard_db              => 'dashboard_prod',
        dashboard_site            => $fqdn,
        dashboard_port            => '8080',
        passenger                 => true,
      }
}

None of these parameters are required - if you neglect any of them their values will default back to those set in the dashboard::params subclass.

# Puppet Dashboard Face

The Puppet Dashboard Face requires that the cloud provisioner version 1.0.0 is installed
and in Ruby's loadpath (which can be set with the RUBYLIB environment variable)

To use the Puppet Dashboard Face:


* Ensure that you have Puppet 2.7.6 or greater installed.  This face MAY work on version 2.7.2 or later, but it's not been tested.
* Download or clone puppetlabs-dashboard to your Puppet modulepath (i.e. ~/.puppet/modules or /etc/puppet/modules)
        export RUBYLIB=/etc/puppet/modules/dashboard/lib:$RUBYLIB

* Test the face and learn more about its usage

        puppet help dashboard

# Feature Requests

* Sqlite support.
* Integration with Puppet module to set puppet.conf settings.

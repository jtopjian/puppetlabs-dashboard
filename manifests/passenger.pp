# Class: dashboard::passenger
#
# This class configures parameters for the puppet-dashboard module.
#
# Parameters:
#   [*dashboard_site*]
#     - The ServerName setting for Apache
#
#   [*dashboard_port*]
#     - The port on which puppet-dashboard should run
#
#   [*dashboard_config*]
#     - The Dashboard configuration file
#
#   [*dashboard_root*]
#     - The path to the Puppet Dashboard library
#
#   [*dashboard_user*]
#     - Name of the puppet-dashboard database and
#       system user
#
#   [*dashboard_group*]
#     - Name of the puppet-dashboard group
#
#   [*dashboard_password*]
#     - Password for the puppet-dashboard database use
#
#   [*dashboard_auth_file*]
#     - Full path to the htaccess file for apache htaccess authentication
#     - Requires htaccess module to create the file
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class dashboard::passenger (
  $dashboard_site,
  $dashboard_port,
  $dashboard_config,
  $dashboard_root,
  $dashboard_user,
  $dashboard_group,
  $dashboard_password,
  $dashboard_auth_file
) inherits dashboard {

  require ::passenger
  include apache

  file { '/etc/init.d/puppet-dashboard':
    ensure => absent,
  }

  file { 'dashboard_config':
    ensure => absent,
    path   => $dashboard_config,
  }

  apache::vhost { $dashboard_site:
    port     => $dashboard_port,
    priority => '50',
    docroot  => "${dashboard_root}/public",
    template => 'dashboard/passenger-vhost.erb',
  }

  file { $dashboard_auth_file:
    ensure => present,
    owner  => $dashboard_user,
    group  => $dashboard_group,
    mode   => '0644',
  }

  httpauth { $dashboard_user:
    password   => $dashboard_password,
    file       => $dashboard_auth_file,
    mechanism  => basic,
    ensure     => present,
  }

}

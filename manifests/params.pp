# Class: dashboard::params
#
# This class configures parameters for the puppet-dashboard module.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class dashboard::params {

  $dashboard_ensure      = 'present'
  $dashboard_user        = 'puppet-dashboard'
  $dashboard_group       = 'puppet-dashboard'
  $dashboard_password    = 'changeme'
  $dashboard_db          = 'dashboard_production'
  $dashboard_db_host     = 'localhost'
  $dashboard_charset     = 'utf8'
  $dashboard_environment = 'production'
  $dashboard_site        = $::fqdn
  $dashboard_port        = '8080'
  $dashboard_auth_file   = '/usr/share/puppet-dashboard/config/.htaccess'
  $passenger             = false
  $rails_base_uri        = '/'
  $rack_version          = '1.1.2'

  case $::osfamily {

    'RedHat': {
      $dashboard_config       = '/etc/sysconfig/puppet-dashboard'
      $dashboard_service      = 'puppet-dashboard'
      $dashboard_package      = 'puppet-dashboard'
      $dashboard_root         = '/usr/share/puppet-dashboard'
    }

    'Debian': {
      $dashboard_config       = '/etc/default/puppet-dashboard'
      $dashboard_service      = 'puppet-dashboard'
      $dashboard_package      = 'puppet-dashboard'
      $dashboard_root         = '/usr/share/puppet-dashboard'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}


# == Class: pgpool2::params
#
# pgpool2 class parameters
#
class pgpool2::params {

  # Global config params
  $package_ensure             = 'present'
  $service_enable             = true
  $service_ensure             = 'running'
  $service_manage             = true
  $pgpool_log_debug           = 'no'
  $pgpool_default_template    = 'pgpool2/etc_default_pgpool2.erb'

  # PGPOOL Config Parameters
  # - Connection Settings -
  $listen_addresses           = '*'
  $port                       = 5432
  $socket_dir                 = '/var/run/postgresql'

  # - Communication Manager Connection Settings -
  $pcp_port                   = 9898
  $pcp_socket_dir             = '/var/run/postgresql'

  # - Backend Connection Settings -
  $backend_hostname0          = ''
  $backend_port0              = 5432
  $backend_weight0            = 1
  $backend_data_directory0    = '/var/lib/postgresql/9.3/main'
  $backend_flag0              = 'ALLOW_TO_FAILOVER'
  $backend_hostname1          = ''
  $backend_port1              = 5432
  $backend_weight1            = 1
  $backend_data_directory1    = '/var/lib/postgresql/9.3/main'
  $backend_flag1              = 'ALLOW_TO_FAILOVER'

  # - Authentication -
  $enable_pool_hba            = 'on'

  # - Logs -
  $log_destination            = 'stderr'

  # - Debug -
  $debug_level                = 1

  # - Replication Mode -
  $replication_mode           = 'on'

  # - Load Balancing Mode -
  $load_balance_mode          = 'on'

  case $::osfamily {
    'Debian': {
      $confdir                = '/etc/pgpool2'
      $pgpool_conf_path       = "${confdir}/pgpool.conf"
      $pool_hba_conf_path     = "${confdir}/pool_hba.conf"
      $pool_passwd_conf_path  = "${confdir}/pool_passwd"
      $pcp_conf_path          = "${confdir}/pcp.conf"
      $defaults_config        = '/etc/default/pgpool2'
      $config_template        = 'pgpool2/pgpool.conf.erb'
      $package_name           = [ 'pgpool2' ]
      $service_name           = 'pgpool2'
      $pgpool_log_dir         = '/var/log/postgresql'
      $pgpool2_log_conf_path  = "${pgpool_log_dir}/pgpool.log"
    }

    # TODO: Add support for more Operating Systems
    # 'RedHat': {
    #   $confdir                = pick($confdir, "/etc/pgpool2")
    #   $pool_hba_conf_path     = pick($pool_hba_conf_path, "${confdir}/pool_hba.conf")
    #   $pool_passwd_conf_path  = pick($pool_passwd_conf_path, "${confdir}/pool_passwd.conf")
    #   $pcp_conf_path          = pick($pcp_conf_path, "${confdir}/pcp.conf")
    #   $defaults_config        = '/etc/default/pgpool2'
    #   $config_template        = 'pgpool2/pgpool.conf.erb'
    #   $package_name           = [ 'pgpool2' ]
    #   $service_name           = 'pgpool2'
    # }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}

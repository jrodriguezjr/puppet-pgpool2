# == Class: pgpool2::params
#
# pgpool2 class parameters
#
class pgpool2::params {

  # Global Config Parameters
  $package_ensure             = 'present'
  $service_enable             = true
  $service_ensure             = 'running'
  $service_manage             = true
  $pgpool_log_debug           = 'no'
  $pgpool_syslog_facility     = 'local1'
  $pgpool_default_template    = 'pgpool2/etc_default_pgpool2.erb'
  $pgpool_rsyslog_template    = 'pgpool2/rsyslog_pgpool2.conf.erb'

  # PGPOOL Config Parameters - start
  # - CONNECTION SETTINGS -
  $listen_addresses           = '*'
  $port                       = 5432
  $socket_dir                 = '/var/run/postgresql'

  # -- Communication Manager Connection Settings -
  $pcp_port                   = 9898
  $pcp_socket_dir             = '/var/run/postgresql'

  # -- Backend Connection Settings -
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

  # -- Authentication -
  $enable_pool_hba            = 'on'

  # - POOLS
  # -- Pool size -
  $num_init_children          = 32
  $max_pool                   = 4

  # -- Life time -
  $child_life_time            = 300
  $child_max_connections      = 0
  $connection_life_time       = 0
  $client_idle_limit          = 0

  # - LOGS -
  $log_destination            = 'syslog'

  # -- What to log -
  $print_timestamp            = off
  $log_connections            = off
  $log_hostname               = off
  $log_statement              = off
  $log_per_node_statement     = off
  $log_standby_delay          = 'none'

  # -- Syslog specific -
  $syslog_facility            = 'LOCAL1'
  $syslog_ident               = 'pgpool'

  # -- Debug -
  $debug_level                = 0

  # - REPLICATION MODE -
  $replication_mode           = 'off'

  # - LOAD BALANCING MODE -
  $load_balance_mode          = 'off'

  # - MASTER/SLAVE MODE -
  $master_slave_mode          = 'off'
  $master_slave_sub_mode      = 'stream'

  # -- M/S Streaming -
  $sr_check_period            = 0
  $sr_check_user              = 'nobody'
  $sr_check_password          = ''
  $delay_threshold            = 0

  # -- M/S Special commands -
  $follow_master_command      = ''

  # - HEALTH CHECK -
  $health_check_period        = 10
  $health_check_timeout       = 20
  $health_check_user          = 'nobody'
  $health_check_password      = ' '
  $health_check_max_retries   = 0
  $health_check_retry_delay   = 1
  # PGPOOL Config Parameters - end

  # pgpool-II replication manager - PCP Configuration
  $pgmgr_pcp_host             = "127.0.0.1"
  $pgmgr_pcp_port             = "9898"
  $pgmgr_pcp_username         = "pgpool"
  $pgmgr_pcp_password         = ''
  $pgmgr_pcp_timeout          = "10"
  $pgmgr_psql_healthcheck_opts= "-U replicate -d postgres"

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
      $pgmgr_pcp_template     = 'pgpool2/pgpoolmanager.erb'

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

# == Class: pgpool2
#
# pgpool2 main class
#
class pgpool2 (
  $package_ensure                 = $pgpool2::params::package_ensure,
  $service_enable                 = $pgpool2::params::service_enable,
  $service_ensure                 = $pgpool2::params::service_ensure,
  $service_manage                 = $pgpool2::params::service_manage,
  $pgpool_log_debug               = $pgpool2::params::pgpool_log_debug,
  $pgpool_syslog_facility         = $pgpool2::params::pgpool_syslog_facility,
  $pgpool_default_template        = $pgpool2::params::pgpool_default_template,
  $pgpool_rsyslog_template        = $pgpool2::params::pgpool_rsyslog_template,

  $listen_addresses               = $pgpool2::params::listen_addresses,
  $port                           = $pgpool2::params::port,
  $socket_dir                     = $pgpool2::params::socket_dir,

  $pcp_port                       = $pgpool2::params::pcp_port,
  $pcp_socket_dir                 = $pgpool2::params::pcp_socket_dir,

  $backend_hostname0              = $pgpool2::params::backend_hostname0,
  $backend_port0                  = $pgpool2::params::backend_port0,
  $backend_weight0                = $pgpool2::params::backend_weight0,
  $backend_data_directory0        = $pgpool2::params::backend_data_directory0,
  $backend_flag0                  = $pgpool2::params::backend_flag0,
  $backend_hostname1              = $pgpool2::params::backend_hostname1,
  $backend_port1                  = $pgpool2::params::backend_port1,
  $backend_weight1                = $pgpool2::params::backend_weight1,
  $backend_data_directory1        = $pgpool2::params::backend_data_directory1,
  $backend_flag1                  = $pgpool2::params::backend_flag1,

  $enable_pool_hba                = $pgpool2::params::enable_pool_hba,

  $num_init_children              = $pgpool2::params::num_init_children,
  $max_pool                       = $pgpool2::params::max_pool,

  $child_life_time                = $pgpool2::params::child_life_time,
  $child_max_connections          = $pgpool2::params::child_max_connections,
  $connection_life_time           = $pgpool2::params::connection_life_time,
  $client_idle_limit              = $pgpool2::params::client_idle_limit,

  $log_destination                = $pgpool2::params::log_destination,
  $log_standby_delay              = $pgpool2::params::log_standby_delay,

  $print_timestamp                = $pgpool2::params::print_timestamp,
  $log_connections                = $pgpool2::params::log_connections,
  $log_hostname                   = $pgpool2::params::log_hostname,
  $log_statement                  = $pgpool2::params::log_statement,
  $log_per_node_statement         = $pgpool2::params::log_per_node_statement,
  $log_standby_delay              = $pgpool2::params::log_standby_delay,

  $syslog_facility                = $pgpool2::params::syslog_facility,
  $syslog_ident                   = $pgpool2::params::syslog_ident,

  $debug_level                    = $pgpool2::params::debug_level,

  $replication_mode               = $pgpool2::params::replication_mode,

  $load_balance_mode              = $pgpool2::params::load_balance_mode,

  $master_slave_mode              = $pgpool2::params::master_slave_mode,
  $master_slave_sub_mode          = $pgpool2::params::master_slave_sub_mode,

  $sr_check_period                = $pgpool2::params::sr_check_period,
  $sr_check_user                  = $pgpool2::params::sr_check_user,
  $sr_check_password              = $pgpool2::params::sr_check_password,
  $delay_threshold                = $pgpool2::params::delay_threshold,

  $follow_master_command          = $pgpool2::params::follow_master_command,

  $health_check_period            = $pgpool2::params::health_check_period,
  $health_check_timeout           = $pgpool2::params::health_check_timeout,
  $health_check_user              = $pgpool2::params::health_check_user,
  $health_check_password          = $pgpool2::params::health_check_password,
  $health_check_max_retries       = $pgpool2::params::health_check_max_retries,
  $health_check_retry_delay       = $pgpool2::params::health_check_retry_delay,

  $confdir                        = $pgpool2::params::confdir,
  $pgpool_conf_path               = $pgpool2::params::pgpool_conf_path,
  $pool_hba_conf_path             = $pgpool2::params::pool_hba_conf_path,
  $pool_passwd_conf_path          = $pgpool2::params::pool_passwd_conf_path,
  $pcp_conf_path                  = $pgpool2::params::pcp_conf_path,
  $defaults_config                = $pgpool2::params::defaults_config,
  $config_template                = $pgpool2::params::config_template,
  $package_name                   = $pgpool2::params::package_name,
  $service_name                   = $pgpool2::params::service_name,
  $pgpool_log_dir                 = $pgpool2::params::pgpool_log_dir,
  $pgpool2_log_conf_path          = $pgpool2::params::pgpool2_log_conf_path,

  $pgmgr_pcp_host                 =$pgpool2::params::pgmgr_pcp_host,
  $pgmgr_pcp_port                 =$pgpool2::params::pgmgr_pcp_port,
  $pgmgr_pcp_username             =$pgpool2::params::pgmgr_pcp_username,
  $pgmgr_pcp_password             =$pgpool2::params::pgmgr_pcp_password,
  $pgmgr_pcp_timeout              =$pgpool2::params::pgmgr_pcp_timeout,
  $pgmgr_psql_healthcheck_opts    =$pgpool2::params::pgmgr_psql_healthcheck_opts,
  $pgmgr_pcp_template             = $pgpool2::params::pgmgr_pcp_template,

) inherits pgpool2::params {

  # Sanity Checks: Input Param Validations
  # TODO: need to add more validation on params
  validate_absolute_path($confdir)
  validate_string($config_template)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_bool($service_enable)


  # Include other classes
  include '::pgpool2::install'
  include '::pgpool2::config'
  include '::pgpool2::service'
  include '::concat::setup'

  # Anchor this ship!
  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'pgpool2::begin': }
  anchor { 'pgpool2::end': }

  Anchor['pgpool2::begin'] -> Class['::pgpool2::install'] -> Class['::pgpool2::config']
    ~> Class['::pgpool2::service'] -> Anchor['pgpool2::end']
}

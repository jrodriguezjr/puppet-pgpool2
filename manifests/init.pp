# == Class: pgpool2
#
# pgpool2 main class
#
class pgpool2 (
  $package_ensure           = $pgpool2::params::package_ensure,
  $service_enable           = $pgpool2::params::service_enable,
  $service_ensure           = $pgpool2::params::service_ensure,
  $service_manage           = $pgpool2::params::service_manage,
  $confdir                  = $pgpool2::params::confdir,
  $pgpool_conf_path         = $pgpool2::params::pgpool_conf_path,
  $pool_hba_conf_path       = $pgpool2::params::pool_hba_conf_path,
  $pool_passwd_conf_path    = $pgpool2::params::pool_passwd_conf_path,
  $pcp_conf_path            = $pgpool2::params::pcp_conf_path,
  $defaults_config          = $pgpool2::params::defaults_config,
  $config_template          = $pgpool2::params::config_template,
  $package_name             = $pgpool2::params::package_name,
  $service_name             = $pgpool2::params::service_name,
  $pgpool_log_debug         = $pgpool2::params::pgpool_log_debug,
  $pgpool_default_template  = $pgpool2::params::pgpool_default_template,
  $pgpool_log_dir           = $pgpool2::params::pgpool_log_dir,
  $pgpool2_log_conf_path    = $pgpool2::params::pgpool2_log_conf_path,

  $listen_addresses         = $pgpool2::params::listen_addresses,
  $port                     = $pgpool2::params::port,
  $socket_dir               = $pgpool2::params::socket_dir,
  $pcp_port                 = $pgpool2::params::pcp_port,
  $pcp_socket_dir           = $pgpool2::params::pcp_socket_dir,
  $backend_hostname0        = $pgpool2::params::backend_hostname0,
  $backend_port0            = $pgpool2::params::backend_port0,
  $backend_weight0          = $pgpool2::params::backend_weight0,
  $backend_data_directory0  = $pgpool2::params::backend_data_directory0,
  $backend_flag0            = $pgpool2::params::backend_flag0,
  $backend_hostname1        = $pgpool2::params::backend_hostname1,
  $backend_port1            = $pgpool2::params::backend_port1,
  $backend_weight1          = $pgpool2::params::backend_weight1,
  $backend_data_directory1  = $pgpool2::params::backend_data_directory1,
  $backend_flag1            = $pgpool2::params::backend_flag1,
  $enable_pool_hba          = $pgpool2::params::enable_pool_hba,
  $log_destination          = $pgpool2::params::log_destination,
  $debug_level              = $pgpool2::params::debug_level,
  $replication_mode         = $pgpool2::params::replication_mode,
  $load_balance_mode        = $pgpool2::params::load_balance_mode,

) inherits pgpool2::params {

  # Sanity Checks: Input Param Validations
  validate_absolute_path($confdir)
  validate_string($config_template)
  validate_string($package_ensure)
  validate_array($package_name)
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

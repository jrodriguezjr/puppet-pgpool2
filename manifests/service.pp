# == Class: pgpool2::service
#
# pgpool2 service management
#
class pgpool2::service inherits pgpool2 {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    # Run pgpool2 service
    service { 'pgpool2':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}

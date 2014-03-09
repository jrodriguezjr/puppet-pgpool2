# == Class: pgpool2::uninstall
#
# pgpool2 package remove
#
class pgpool2::uninstall inherits pgpool2 {

  package { 'pgpool2':
    ensure => 'purged',
    name   => $package_name,
  }
}

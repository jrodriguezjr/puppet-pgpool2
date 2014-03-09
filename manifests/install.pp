# == Class: pgpool2::install
#
# pgpool2 package install
#
class pgpool2::install inherits pgpool2 {

  package { 'pgpool2':
    ensure => $package_ensure,
    name   => $package_name,
  }
}

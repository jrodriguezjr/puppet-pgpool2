# == Define: pgpool2::server::pool_hba
#
# pgpool-II pool_hba defined resource. This resource helps define pgpool hba
# rules similar to pg_hba rules.
# ref: http://pgpool.projects.pgfoundry.org/pgpool-II/doc/pgpool-en.html#hba
#
# === Parameters
#
# [*type*]
#   Originination type. (valid values are: host, localhost, local)
#
# [*database*]
#   Name of the database to use.
#
# [*user*]
#   DB username.
#
# [*auth_method*]
#   Authentication method.
#
# [*address*]
#   Addresses.
#
# [*description*]
#   Resources description.
#
# [*auth_option*]
#   Authentication options.
#
# [*order*]
#   Order of concatination script.
#
# [*target*]
#   Name of target file.
#
define pgpool2::server::pool_hba_rule(
  $type,
  $database,
  $user,
  $auth_method,
  $address     = undef,
  $description = 'none',
  $auth_option = undef,
  $order       = '150',
  $target      = '/etc/pgpool2/pool_hba.conf'
) {

  # Sanity checks
  validate_re($type, '^(local|host|hostssl|hostnossl)$',
  "The type you specified [${type}] must be one of: local, host, hostssl, hostnosssl")

  # Create a rule fragment
  $fragname = "pool_hba_rule_${name}"
  concat::fragment { $fragname:
    target  => $target,
    content => template('pgpool2/pool_hba.conf.erb'),
    order   => $order,
    owner   => $::id,
    mode    => '0600',
  }
}

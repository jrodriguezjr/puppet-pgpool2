# This resource manages an individual rule that applies to the file defined in
# $target. See README.md for more details.
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

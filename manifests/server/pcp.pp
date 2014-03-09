
define pgpool2::server::pcp(
  $user,
  $pg_md5,
  $order       = '150',
  $target      = '/etc/pgpool2/pcp.conf'
) {

  # Sanity checks
  validate_string($user,
  "The type you specified [${user}] can not be blank.")
  validate_string($pg_md5,
  "The type you specified [${pg_md5}] can not be blank.")

  # Create a rule fragment
  $fragname = "pool_password_${name}"
  concat::fragment { $fragname:
    target  => $target,
    content => template('pgpool2/pcp.conf.erb'),
    order   => $order,
    owner   => $::id,
    mode    => '0600',
  }
}

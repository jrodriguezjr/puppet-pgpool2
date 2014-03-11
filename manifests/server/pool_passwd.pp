# == Define: pgpool2::server::pool_passwd
#
# pgpool-II pool_passwd defined resource.
#
# === Parameters
#
# Document parameters here
#
# [*user*]
#   DB username.
#
# [*pg_md5*]
#   pg_md5 md5 sum of user password.  you can get this form pg_md5 <user>
#
# [*order*]
#   Order of concatination snippet.
#
# [*target*]
#   Name of target file.
#
define pgpool2::server::pool_passwd(
  $user,
  $pg_md5,
  $order       = '150',
  $target      = '/etc/pgpool2/pool_passwd'
) {

  # Sanity checks
  validate_string($user,
  "The type you specified [${user}] can not be blank.")
  validate_string($pg_md5,
  "The type you specified [${pg_md5}] can not be blank.")
  validate_re($pg_md5, '^md5',
  "The type you specified [${pg_md5}] must be a MD5 checksum.")

  # Create a rule fragment
  $fragname = "pool_password_${name}"
  concat::fragment { $fragname:
    target  => $target,
    content => template('pgpool2/pool_passwd.erb'),
    order   => $order,
    owner   => $::id,
    mode    => '0600',
  }
}

# == Define: pgpool2::server::pcp
#
# pgpool-II pcp defined resource. This resource will help setup auth to the
# pgpool administration interface.
# ref: http://www.pgpool.net/docs/latest/tutorial-en.html
#
# === Parameters
#
# Document parameters here
#
# [*user*]
#   pgpool pcp username.
#
# [*pg_md5*]
#   pg_md5 md5 sum of user password.  You can get this form pg_md5 <user>
#   example: /usr/bin/pg_md5 postgres
#
# [*order*]
#   Order of concatination snippet for concat.
#
# [*target*]
#   Name of target file.
#
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

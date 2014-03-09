# == Class: pgpool2::config
#
# pgpool2 config settings
#
class pgpool2::config inherits pgpool2 {

  # make sure the pgpool log directory lives
  file { '/etc/pgpool2':
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0755',
  }

  # main pgpool2 config
  file { $pgpool_conf_path:
    ensure  => file,
    owner   => 0,
    group   => postgres,
    mode    => '0644',
    content => template($config_template),
  }

  # etc defaults for pgpool
  file { '/etc/default/pgpool':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($pgpool_default_template),
  }

  # If Debian use our init.d
  if ($::osfamily == "Debian") {
    file { '/etc/init.d/pgpool2':
      ensure  => present,
      owner   => 0,
      group   => postgres,
      mode    => '0755',
      source  => 'puppet:///modules/pgpool2/init.d_pgpool2.DEBIAN'
    }
  }

  # make sure the pgpool log directory lives
  file { '/var/log/postgresql':
    ensure  => directory,
    target  => $pgpool2_log_dir,
    owner   => 0,
    group   => postgres,
    mode    => '1775',
  }

  # create the pgpool log file
  file { $pgpool2_log_conf_path:
    ensure  => file,
    owner   => 0,
    group   => postgres,
    mode    => '1775',
  }

  # Concat definitions:
  concat { $pool_hba_conf_path:
    owner  => 0,
    group  => 0,
    mode   => '0644',
    # warn   => true,
  }

  concat { $pcp_conf_path:
    owner  => 0,
    group  => 0,
    mode   => '0644',
    # warn   => true,
  }

  concat { $pool_passwd_conf_path:
    owner  => 0,
    group  => 0,
    mode   => '0644',
    # warn   => true,
  }

}

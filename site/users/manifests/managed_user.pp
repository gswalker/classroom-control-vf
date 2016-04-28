define users::managed_user (
  $ensure     = 'present',
  $managehome = true,
  $shell      = '/bin/bash',
  $groups     = undef,
  $group      = $title,
  $home       = "/home/${title}",
) {
  user { $title:
    ensure     => $ensure,
    managehome => $managehome,
    shell      => $shell,
    gid        => $group,
    groups     => $groups,
    home       => $home,
  }
  if $ensure == 'present' {
    group { $group:
      ensure => present,
    }
    file { "${home}/.ssh":
      ensure => directory,
      owner  => $title,
      group  => $group,
      mode   => '0750',
    }
  }
}

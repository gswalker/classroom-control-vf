class skeleton {
  file { '/etc/skel':
    ensure => directory,
  }
  file { '/etc/skel/.bashrc':
    ensure => file,
    content => 'puppet://modules/skeleton/puppet.bashrc'
  }
}

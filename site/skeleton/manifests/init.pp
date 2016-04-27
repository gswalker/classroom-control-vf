class skeleton {
  file { '/etc/skel':
    ensure => directory,
  }
  file { '/etc/skel/.bashrc':
    ensure => file,
    notify => 'Test',
    content => 'puppet://modules/skeleton/puppet.bashrc'
  }
}

class nginx {
  case $::osfamily {
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html' 
      $confdir = 'C:/ProgramData/nginx' 
      $logdir = 'C:/ProgramData/nginx/logs'
    }
    'debian', 'redhat': { 
      $package = 'nginx' 
      $owner = 'root'
      $group = 'root' 
      $docroot = '/var/www' 
      $confdir = '/etc/nginx' 
      $logdir = '/var/log/nginx'
    }
  }
  $user = $::osfamily ? {
    'windows' => 'nobody',
    'debian' => 'www-data',
    'redhat' => 'nginx',
  }
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { $package:
    ensure => present,
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
  }
  file { "${confdir}/conf.d":
    ensure => directory,
  }
#  file { ${docroot}:
#    ensure => director,
#  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}

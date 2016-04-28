class nginx {
  case $::osfamily {
    'windows' : {
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
  default : {
    fail("${module_name} is not supported under ${::osfamily}") 
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
  file { "${docroot}/$confdir/conf.d":
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}

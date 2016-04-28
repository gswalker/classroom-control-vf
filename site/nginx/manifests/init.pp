class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package { 'nginx':
    ensure => present,
  }
  file { '/var/www':
    ensure => directory,
  }
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/':
    ensure => directory,
  }
  file { '/etc/nginx/conf.d/defaults.conf':
    ensure => file,
.    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}

package { ‘memcached’:
 ensure => present,
}
file { ‘/etc/sysconfig/memcached’:
 ensure => file,
 owner => ‘root’,
 group => ‘root’,
 mode => ‘0644’,
 source => ‘puppet:///modules/memcached/memecached.conf',
 require => Package[‘memcached’],
}

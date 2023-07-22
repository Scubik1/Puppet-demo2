node master.puppet {
  include nginx
  nginx::resource::server { 'Redirect to slave1.puppet':
    listen_port => 80,
    proxy       => 'http://192.168.50.10',
  }
  nginx::resource::server { 'Redirect to slave2.puppet':
    listen_port => 81,
    proxy       => 'http://192.168.50.15',
  }
  
  class { 'firewalld': }
  
  class firewall_node1 {
    firewalld_port { 'Open 80 and 81 ports':
      ensure   => present,
      zone     => 'public',
      port     => 80,
      protocol => 'tcp',
    }
  }
  include firewall_node1
}


node slave1.puppet {
  package { 'httpd':
    ensure => installed,
  }
  file { '/var/www/html/index.html':
    ensure => present,
    source => "/vagrant/index.html",
  }
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  exec {'Add port to firewall':
    path    => '/usr/bin',
    command => 'firewall-cmd --add-port=80/tcp --permanent',
  }
  exec { 'Restart firewall':
    command => '/usr/bin/systemctl restart firewalld',
    path    => '/usr/bin',
  }
}

node slave2.puppet {
  package { 'httpd':
    ensure => installed,
  }
  package { 'php':
    ensure => installed,
  }
  file { '/var/www/html/index.php':
    ensure => present,
    source => "/vagrant/index.php",
  }
#  service { 'php-fpm':
 #   ensure => running,
  #  enable => true,
  #}
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  exec {'Add port to firewall':
    path    => '/usr/bin',
    command => 'firewall-cmd --add-port=80/tcp --permanent',
  }
  exec { 'Restart firewall':
    command => '/usr/bin/systemctl restart firewalld',
    path    => '/usr/bin',
  }
}

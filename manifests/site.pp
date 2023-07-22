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
  include firewall_open_port_80
  include firewall_open_port_81
  selboolean { 'On httpd_can_network_connect in SELinux':
    name       => 'httpd_can_network_connect',
    persistent => true,
    value      => on,
  }
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
  include firewall_open_port_80
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
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  include firewall_open_port_80
}

node mineserver.puppet {
  include minecraft
}

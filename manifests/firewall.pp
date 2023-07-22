  class { 'firewalld': }
  
  class firewall_open_port_80 {
    firewalld_port { 'Open port 80':
      ensure   => present,
      zone     => 'public',
      port     => 80,
      protocol => 'tcp',
    }
  }

  class firewall_open_port_81 {
    firewalld_port { 'Open port 81':
      ensure   => present,
      zone     => 'public',
      port     => 81,
      protocol => 'tcp',
    }
  }

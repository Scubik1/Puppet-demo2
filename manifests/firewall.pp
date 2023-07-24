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

  class firewall_open_port_25565_tcp {
    firewalld_port { 'Open port 25565':
      ensure   => present,
      zone     => 'public',
      port     => 25565,
      protocol => 'tcp',
    }
  }

  class firewall_open_port_25565_udp {
    firewalld_port { 'Open port 25565':
      ensure   => present,
      zone     => 'public',
      port     => 25565,
      protocol => 'tcp',
    }
  }

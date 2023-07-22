  class { 'firewalld': }
  
  class firewall_node1 {
    firewalld_port { 'Open 80 and 81 ports':
      ensure   => present,
      zone     => 'public',
      port     => 80,
      protocol => 'tcp',
    }
  }

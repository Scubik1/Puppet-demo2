class minecraft {
  package {  'Install java':
    name   => java-17-openjdk.x86_64,
    ensure => present,
  }
  file { '/opt/minecraft':
    ensure => directory,
  }
  file { 'Download minecraft server':
    path   => '/opt/minecraft/server.jar',
    ensure => file,
    source => 'https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar',
  } 
  file { '/opt/minecraft/eula.txt':
    content => "eula=true",
   # require => Exec['init start server'],
  }  
  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
  service { 'minecraft.service':
    ensure => running,
    enable => true,
    #require => File['/etc/systemd/system/minecraft.service'],
  }
}

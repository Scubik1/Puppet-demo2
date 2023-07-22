class minecraft {
  wget::retrieve { 'download minecraft server':
    source      => 'https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar',
    destination => '/opt/minecraft/',
    timeout     => 0,
    verbose     => false,
  }
}

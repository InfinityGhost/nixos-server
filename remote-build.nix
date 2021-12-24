{
  # Remote build
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "192.168.0.2";
        sshUser = "infinity";
        systems = [
          "x86_64-linux"
          "i686-linux"
        ];
        speedFactor = 10;
      }
      {
        hostName = "192.168.0.4";
        sshUser = "infinity";
        systems = [
          "x86_64-linux"
          "i686-linux"
        ];
        speedFactor = 8;
      }
    ];
  };
}

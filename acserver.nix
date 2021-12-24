{ pkgs, ... }:

{
  systemd.services.acserver = {
    serviceConfig = {
      ExecStart = "/media/Games/Servers/Assetto/acServer";
      WorkingDirectory = "/media/Games/Servers/Assetto";
    };
    description = "Assetto Corsa Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
  };
}

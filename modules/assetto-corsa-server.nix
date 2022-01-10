{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.assetto-corsa-server;
  serverCfg = "${cfg.dataDir}/cfg";

  script = pkgs.writeText "install-script" ''
    @ShutdownOnFailedCommand 1
    @sSteamCmdForcePlatformType windows
    force_install_dir ${cfg.dataDir}
    login ${cfg.steam.user}
    app_update 302550 validate
    quit
  '';

  installScript = pkgs.writeShellScriptBin "assetto-corsa-server-install" ''
    ${pkgs.steamcmd}/bin/steamcmd +runscript ${script}
  '';

in {
  options = {
    services.assetto-corsa-server = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          This enables the Assetto Corsa server.
        '';
      };

      dataDir = mkOption {
        type = types.path;
        default = "/var/lib/assetto-corsa-server";
        description = ''
          Directory in which the Assetto Corsa server is located.
        '';
      };

      binPath = mkOption {
        type = types.path;
        default = "${cfg.dataDir}/acServer";
        description = ''
          Executable to invoke to run the Assetto Corsa server.
        '';
      };

      steam = {
        user = mkOption {
          type = types.str;
          default = "";
          description = ''
            User in which to log in with the steam user script.
          '';
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      installScript
    ];

    systemd = {
      services = {
        assetto-corsa-server = {
          description = "Assetto Corsa Server";
          serviceConfig = {
            ExecStart = cfg.binPath;
            WorkingDirectory = cfg.dataDir;
          };
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
        };

        assetto-corsa-server-watcher = {
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.systemd}/bin/systemctl restart assetto-corsa-server.service";
          };
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
        };
      };

      paths.assetto-corsa-server-watcher = {
        pathConfig = {
          PathChanged = serverCfg;
          Unit = "assetto-corsa-server-watcher";
        };
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
      };
    };
  };
}
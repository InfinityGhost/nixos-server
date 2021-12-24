{ pkgs, lib, ... }:

let
  allocatedMemory = "1536M";
in
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.papermc;
    jvmOpts = lib.concatStringsSep " " [
      "-Xmx${allocatedMemory}"
      "-Xms${allocatedMemory}"
      "-XX:+UseG1GC"
      "-XX:ParallelGCThreads=2"
      "-XX:MinHeapFreeRatio=5"
      "-XX:MaxHeapFreeRatio=10"
    ];
    serverProperties = {
      server-port = 25565;
      difficulty = 2;
      gamemode = 0;
      max-players = 5;
      motd = "Minecraft Server";
      white-list = false;
      enable-rcon = false;
    };
  };
}

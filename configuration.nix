{ config, pkgs, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./storage.nix
      ./users.nix
      ./nfs.nix
    ];

  # GRUB 2
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Network
  networking.hostName = "nixos-server";

  # DHCP on network interface enp3s0
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # Allow remote building
  nix = {
    distributedBuilds = true;
    trustedUsers = [
      "infinity"
      "@root"
    ];
  };
  
  # Automatically update packages
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Plex
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  # Enable the git daemon
  services.gitDaemon = {
    enable = true;
    basePath = "/media/Repos";
  };
  users.users.git = {
    shell = "${pkgs.git}/bin/git-shell";
    home = "/home/git";
  };

  # Firewall
  networking.firewall.enable = false;

  # Virtualization
  virtualisation.libvirtd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # NixOS release
  system.stateVersion = "20.03";

}


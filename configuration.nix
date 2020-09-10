# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nfs.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Network
  networking.hostName = "nixos-server"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  # Storage
  fileSystems."/media" = {
    device = "/dev/disk/by-id/wwn-0x5000c500ad6e2c8e-part1";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    git
    neofetch
  ];
  
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # User accounts
  users.users.infinity = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


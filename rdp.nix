{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
    };
    xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.xfce.xfce4-session}/bin/xfce4-session";
    };
  };
}

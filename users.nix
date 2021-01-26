{ pkgs, ... }:

{
  users.users.infinity = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirt"
    ];
    packages = with pkgs; [
      neofetch
    ];
  };
}

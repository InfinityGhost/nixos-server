{
  users.users.infinity = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      neofetch
    ];
  };
}
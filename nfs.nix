{
  # Media export
  fileSystems."/export/media" = {
    device = "/media";
    options = [ "bind" ];
  };  

  # Server configuration
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export/media 192.168.0.0/24(rw,no_subtree_check)
  '';
}

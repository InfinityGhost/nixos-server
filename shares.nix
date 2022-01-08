
let
  createShare = path: {
    inherit path;
    browseable = "yes";
    "acl allow execute always" = "true";
    "read only" = "no";
    "guest ok" = "yes";
    "create mask" = "0644";
    "directory mask" = "0755";
    "force user" = "infinity";
    "force group" = "users";
  };
in
{
  # Media export
  fileSystems."/export/media" = {
    device = "/media";
    options = [ "bind" ];
  };  

  # NFS
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export/media 192.168.0.0/24(rw,no_subtree_check)
  '';

  # Samba
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smb_host_server
      netbios name = smb_host_server
      security = user
      hosts allow = 192.168.0.0/24 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
      server min protocol = NT1
      client min protocol = NT1
    '';
    shares = {
      media = createShare "/media";
    };
  };
}

{
  # Media partition
  fileSystems."/media" = {
    device = "/dev/disk/by-id/wwn-0x5000c500ad6e2c8e-part1";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };
}
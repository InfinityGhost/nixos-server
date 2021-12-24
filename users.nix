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
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDOlaSx7Lz/YUB/KYLmjh3LCMhDK+Gn3aOS7AzNyHv77YhuQ5HvApixMQwh/c20GrVHp6riDbOn7lM1HCbzr4lDEw4QVY5J5O2IZH6g8Ai1sMV/jyJC2G+GvkMUfBIM8y/XUEkXtaz7Y/Xy1l246AJe1E/G8Jqlh/B28KpQzi1OHwKGC8/BDXTYw0q87Zel5EJyjj6xHbEN8iaC1/8KOCGOwrtBXi+4EBeV0AnhfDgQHth1Wu/pc/FOlxTDxmSeQvkgRzITMX9DUa04zSZsiKA8tiUmU+jwb3oATSY6M2DcXnXOsYtvW7RHuGBDyawJfywOCY2TZBMxq3isbY4jVwEv2Z+ecJIa+vawb2we1Wgdrua8xloRoRHyw30L7VO01UP3KB5X4mAONT3kfbgffIbIAM78RxKatK9bFYH5YW+BK4dBpWRVYT8UgOoY5oTXhDwvLiEUvu9jE/K+I3jKwU0RSg0pYmDhTCrNFON4kZcBGLrbZLGi9i0HoeCYQvJboUfgTRO2Hr2FSlgr3YIZwW98bnK0oSSIOEAlNg0qcOSVmPXWuyvNS4Y5Gu0hB7xIYCzkpOqJd9MitQVx+PwKGA4zQT3FJMNpKkqwDKmjWh/ngCcunGOzBbh7z7q3rnMX1EqYaU1WrcfnxbPuX0NUmbWdzg1gPx9/eyJmxrLaCAC5FQ== infinity@win10"
    ];
  };
}

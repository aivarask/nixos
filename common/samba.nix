{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    cifs-utils
    samba
    smbclient-ng
  ];

  services.samba.enable = true;
  services.samba.package = pkgs.samba4Full;
  services.samba.openFirewall = true;
  services.samba.smbd.extraArgs = [ "--configfile=/etc/nixos/smb.conf" ];

  security.wrappers."mount.cifs" = {
    program = "mount.cifs";
    source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
    owner = "root";
    group = "root";
    setuid = true;
  };
}

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
  services.samba.nmbd.enable = false;
  services.samba.winbindd.enable = false;
  services.samba.smbd.extraArgs = [ "--configfile=/etc/nixos/smb.conf" ];
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
    nssmdns4 = true;
    # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
    enable = true;
    openFirewall = true;
  };

  security.wrappers."mount.cifs" = {
    program = "mount.cifs";
    source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
    owner = "root";
    group = "root";
    setuid = true;
  };
}

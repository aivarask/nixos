{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cifs-utils
    samba
    smbclient-ng
  ];
  fileSystems."/mnt/share" = {
    device = "//192.168.1.1/";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/dell/smb-secrets" ];
  };
}

{ ... }:
{
  fileSystems."/mnt/Shares" = {
    device = "//192.168.1.185/mnt/Shares";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/common/smb-secrets" ];
  };
}

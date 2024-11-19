{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    systemctl-tui
    sysz
  ];
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';
}

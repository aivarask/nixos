{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    systemctl-tui
    sysz
  ];
  services.geoclue2 = {
    enable = true;
  };
}

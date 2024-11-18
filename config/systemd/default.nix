{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    systemctl-tui
    sysz
  ];
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';
  services.httpd = {
    enable = false;
  };
  services.httpd.phpPackage = pkgs.php.buildEnv {
    extensions = (
      { enabled, all }:
      enabled
      ++ (with all; [
        xdebug
      ])
    );
    extraConfig = ''
      xdebug.mode=debug
    '';
  };
}

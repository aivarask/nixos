{ pkgs, ... }:
let
  username = "root";
in
{
  # Default username for all tty
  # services.getty = {
  #   loginOptions = "-p -- ${username}";
  #   extraArgs = [
  #     "--noclear"
  #     "--skip-login"
  #   ];
  # };

  # Skip username only for tty1
  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStart = [
      ""
      "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${pkgs.shadow}/bin/login -o '-p -- ${username}' --noclear --skip-login %I $TERM"
    ];
  };
}

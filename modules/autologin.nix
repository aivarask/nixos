{ pkgs, ... }:
let
  username = "root";
in
{
  services.getty.autologinUser = "${username}";
  services.getty.autologinOnce = false;
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] &&
    uwsm start sway-uwsm.desktop

    [[ "$(tty)" == /dev/tty2 ]] &&
    niri-session -l

    [[ "$(tty)" == /dev/tty3 ]] &&
    {}
  '';

  # Default username for all tty
  # services.getty = {
  #   loginOptions = "-p -- ${username}";
  #   extraArgs = [
  #     "--noclear"
  #     "--skip-login"
  #   ];
  # };

  # systemd.services."getty@tty1".overrideStrategy = "asDropin";
  # systemd.services."getty@tty1".serviceConfig.ExecStart = [
  #   #    "@util-linux-2.41.2-bin/sbin/agetty agetty --login-program /bin/login -o '-p -- root' --noclear --skip-login %I $TERM"
  #   ""
  #   "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${pkgs.shadow}/bin/login -o '-p -- ${username}' --noclear --skip-login %I $TERM"
  #   # "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${pkgs.shadow}/bin/login -o '-p -- ${username}' --noclear --skip-login %I $TERM"
  #   # "@${pkgs.util-linux}/sbin/agetty --noreset --noclear --autologin ${username} %I TERM"
  # ];
}

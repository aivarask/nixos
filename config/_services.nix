# vim:foldlevel=4
{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.caddy = {
    enable = false;
  };

  services.libinput = {
    mouse = {
      accelSpeed = "+0.5";
    };
    touchpad = {
      naturalScrolling = true;
      accelSpeed = "+0.5";
    };
  };
  services.locate = {
    enable = true;
  };

  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "ab@localhost"
      "test@test.ekolangas.lt"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "ab@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "test@test.ekolangas.lt".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
  };

}

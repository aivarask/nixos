{
  lib,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.kmscon ];
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = true;

    hwRender = lib.mkDefault true;
    extraConfig = ''
      font-size=${if config.networking.hostName == "dell" then "10" else "6"}
      font-dpi=${toString config.services.xserver.dpi}
    '';
  };
}

{ config, lib, ... }:
{
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = true;
    hwRender = lib.mkDefault true;
    # font-dpi=${toString config.services.xserver.dpi}
    # font-size=${if config.networking.hostName == "dell" then "10" else "12"}
    extraConfig = '''';
  };
}

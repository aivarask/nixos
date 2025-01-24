{ lib, ... }:
{
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = lib.mkDefault true;
    hwRender = lib.mkDefault true;
  };
}

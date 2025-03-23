{ config, ... }:
{
  services.kmscon = {
    hwRender = true;
    extraConfig = ''
      font-dpi=${toString config.services.xserver.dpi}
    '';
  };
}

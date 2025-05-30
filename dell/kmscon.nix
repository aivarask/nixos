{ config, ... }:
{
  services.kmscon = {
    hwRender = true;
    # font-dpi=${toString config.services.xserver.dpi}
    extraConfig = '''';
  };
}

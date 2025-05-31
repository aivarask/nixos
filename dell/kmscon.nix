{ config, ... }:
{
  services.kmscon = {
    extraConfig = ''
      font-dpi=192
    '';
  };
}

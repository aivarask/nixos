{ lib, config, ... }: {
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    hwRender = lib.mkDefault true;
    extraConfig =
      ''
        font-size=12
        font-dpi=${toString config.services.xserver.dpi}
      '';
  };
}

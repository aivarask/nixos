{ lib, pkgs, config, ... }: {
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    hwRender = lib.mkDefault true;
    extraConfig =
      if config.networking.hostName == "dell" then
        ''
          font-size=12
          font-dpi=288
        ''
      else ''
        font-size=12
        font-dpi=72
      '';
    fonts = lib.mkDefault [
      {
        name = "Hack Nerd Font Mono";
        package = pkgs.hack-font;
      }
    ];
  };

}

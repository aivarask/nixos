{ lib, pkgs, ... }: {
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    hwRender = lib.mkDefault true;
    extraConfig = lib.mkDefault ''
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

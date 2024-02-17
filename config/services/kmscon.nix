{ lib, pkgs, config, ... }: {
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    hwRender = lib.mkDefault true;
    extraConfig =
      if config.networking.hostName == "dell" then
        ''
          font-name=DejaVuSans Mono, Noto Color Emoji
          font-size=12
          font-dpi=288
        ''
      else ''
        font-size=12
        font-dpi=72
      '';
    # fonts = [
    #   { name = "Source Code Pro"; package = pkgs.source-code-pro; }
    #   { name = "Noto Color Emoji"; package = pkgs.noto-fonts-color-emoji; }
    # ];
  };
}

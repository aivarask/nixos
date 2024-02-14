{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fontpreview ];
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      (nerdfonts.override {
        # https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/data/fonts/nerdfonts/shas.nix
        fonts = [
          "Hack"
          # "Noto"
          # "SourceCodePro"
          # "FantasqueSansMono"
          # "Iosevka"
          # "FiraMono"
          # "FiraCode"
          # "VictorMono"
          # "SpaceMono"
          # "JetBrainsMono"
          # "DejaVuSansMono"
          # "NerdFontsSymbolsOnly"
        ];
      })
      # hack-font
      # fira-code
      # fira-code-symbols
      joypixels
      # openmoji-color
      # twitter-color-emoji
    ];
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.autohint = true;
      defaultFonts = {
        # fc-list --format="%{family}\n"
        # fc-match emoji
        emoji = [ "JoyPixels" ];
        monospace = [ "Hack Nerd Font Mono" "JoyPixels" ];
        sansSerif = [ "Hack Nerd Font Propo" "JoyPixels" ];
        serif = [ "Hack Nerd Font Propo" "JoyPixels" ];
      };
    };


  };
}

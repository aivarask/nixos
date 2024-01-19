{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      hack-font
      # fira-code
      # fira-code-symbols
      (nerdfonts.override {
        fonts = [
          "Hack"
          "SourceCodePro"
          "FantasqueSansMono"
          "Iosevka"
          "FiraMono"
          "FiraCode"
          "VictorMono"
          "Noto"
        ];
      })
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
        # fc-list --format="%{family}\n"|fzf
        # fc-match emoji
        emoji = [ "JoyPixels" ];
        monospace = [ "Hack Nerd Font Mono" "JoyPixels" ];
        sansSerif = [ "NotoSans Nerd Font" "JoyPixels" ];
        serif = [ "NotoSerif Nerd Font" "JoyPixels" ];
      };
    };

    enableDefaultPackages = true;
  };
}

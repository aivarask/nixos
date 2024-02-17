{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fontpreview ];
  environment.shellAliases = {
    fpe = "fontpreview --preview-text '♥👍😍🙊🥱🥺✨✅🎊🏄'";
  };
  fonts = {
    fontconfig = {
      defaultFonts = {
        # https://mynixos.com/nixpkgs/options/fonts.fontconfig.defaultFonts
        emoji = [
          "Noto Color Emoji"
          "DejaVuSansM Nerd Font Mono"
        ];
        monospace = [ "DejaVu Sans Mono" "DejaVuSansM Nerd Font Mono" ];
        sansSerif = [ "DejaVu Sans" "DejaVuSansM Nerd Font Propo" ];
        serif = [ "DejaVu Serif" "DejaVuSansM Nerd Font Propo" ];
      };
    };
    enableDefaultPackages = false;
    # https://www.nerdfonts.com/cheat-sheet
    packages = with pkgs; [
      noto-fonts-color-emoji
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          "LiberationMono" # suckless default
          "DejaVuSansMono" # system default
          # "Noto" # emoji default
        ];
      })
    ];
  };
}

{ pkgs, ... }:
{
  environment.variables = {
    EMOJI = "♥ ❤️ 👍😍😎🙊🥱🥺✨✅🎊🏄  🇪🇺 ";
  };
  environment.shellAliases = { };
  fonts = {
    fontconfig = {
      defaultFonts = {
        # https://mynixos.com/nixpkgs/options/fonts.fontconfig.defaultFonts
        # https://emojipedia.org/
        emoji = [
          "Noto Color Emoji"
          "DejaVuSansM Nerd Font"
        ];
        monospace = [
          "DejaVuSansM Nerd Font Mono"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Noto Color Emoji"
        ];
        serif = [
          "DejaVu Sans"
          "Noto Color Emoji"
        ];
      };
    };
    enableDefaultPackages = false;
    # https://www.nerdfonts.com/cheat-sheet
    packages = with pkgs; [
      noto-fonts-color-emoji
      (nerdfonts.override {
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
        fonts = [ "DejaVuSansMono" ];
      })
    ];
  };
}

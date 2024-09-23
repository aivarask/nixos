{ pkgs, ... }:
{
  environment.variables = {
    EMOJI = "♥ ❤️ 👍😍😎🙊🥱🥺✨✅🎊🏄  🇪🇺 ";
  };
  environment.shellAliases = { };
  environment.systemPackages= with pkgs; [
      fontpreview
  ];
  fonts = {
    fontconfig = {
      defaultFonts = {
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
    packages = with pkgs; [
      noto-fonts-color-emoji
      (nerdfonts.override {
        fonts = [ "DejaVuSansMono"];
      })
    ];
  };
}

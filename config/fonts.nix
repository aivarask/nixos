{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fontpreview ];
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # twitter-color-emoji
      # twemoji-color-font
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.dejavu-sans-mono
      lato
      nerd-fonts.fira-mono
      nerd-fonts.fira-code
      powerline-fonts

      font-awesome
      noto-fonts-monochrome-emoji

    ];
    fontconfig = {
      defaultFonts = {
        emoji = [
          # "Twitter Color Emoji"
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
  };
}

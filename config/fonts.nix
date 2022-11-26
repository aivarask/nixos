# https://search.nixos.org/options?channel=unstable&from=0&size=1000&sort=relevance&type=packages&query=fonts.fontconfig
# https://discourse.nixos.org/t/how-to-set-system-wide-default-emoji-font/15754/2
# https://search.nixos.org/options?channel=unstable&show=fonts.enableDefaultFonts&from=0&size=1000&sort=relevance&type=packages&query=enableDefaultFonts
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];
  fonts.fonts = with pkgs;
    [
      dina-font
      fira-code
      fira-code-symbols
      font-awesome
      inconsolata-nerdfont
      inter
      iso-flags
      jetbrains-mono
      joypixels
      liberation_ttf
      mplus-outline-fonts.githubRelease
      # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-extra
      proggyfonts
      roboto
      terminus-nerdfont
      twemoji-color-font
      twitter-color-emoji
      ubuntu_font_family
      source-code-pro
      cantarell-fonts

      openmoji-color
    ];

  fonts.enableDefaultFonts = true;
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "OpenMoji Color" ];
    };
  };
}

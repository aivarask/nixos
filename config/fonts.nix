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
    ];
}

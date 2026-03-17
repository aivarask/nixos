{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    pkgs.fzf-preview
    atool
    p7zip
    libcdio
    odt2txt
    catdoc
    gnumeric
    exiftool
    chafa
    mediainfo
    ffmpegthumbnailer
    poppler-utils
  ];

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.enableZshIntegration = true;

}

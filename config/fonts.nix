{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fontpreview ];
  fonts = {
    # enableDefaultPackages = false;
    # packages = with pkgs; [
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
      # (nerdfonts.override { fonts = [ "Noto" ]; })
      # twemoji-color-font
      # unicode-emoji
      # fira-code-nerdfont
      # joypixels
      # font-awesome
      # noto-fonts-color-emoji
      # noto-fonts
      # noto-fonts-cjk
      # noto-fonts-emoji
      # liberation_ttf
      # fira-code
      # fira-code-symbols
      # mplus-outline-fonts.githubRelease
      # dina-font
      # proggyfonts
    # ];
    fontconfig = {
      # antialias = true;
      # cache32Bit = true;
      # hinting.enable = true;
      # hinting.autohint = true;
      # defaultFonts = {
      # # fc-list --format="%{family}\n"
      # # fc-match emoji
      ## fc-match -s monospace:charset=0001f60e
      # emoji = [ "JoyPixels" ];
      # monospace = [ "FiraCode Nerd Font Mono" "monospace" ];
      # sansSerif = [ "sans-serif" ];
      # serif = [ "serif" ];
      # };
    };
  };
}

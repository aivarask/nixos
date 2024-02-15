{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fontpreview ];
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
      # (nerdfonts.override { fonts = [ ]; })
      fira-code-nerdfont
      joypixels
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
        monospace = [ "FiraCode Nerd Font Mono" "monospace" ];
        sansSerif = [ "sans-serif" ];
        serif = [ "serif" ];
      };
    };
  };
}

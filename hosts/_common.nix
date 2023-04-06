{ lib
, pkgs
, ...
}: {
  imports = [ ./_networking.nix ];
  hardware.nvidia.modesetting.enable = lib.mkDefault true;
  services = {
    blueman.enable = lib.mkDefault false;
    kmscon = {
      enable = lib.mkDefault true;
      autologinUser = lib.mkDefault "root";
      hwRender = lib.mkDefault true;
      extraConfig = lib.mkDefault ''
        font-size=12
        font-dpi=72
      '';
      fonts = lib.mkDefault [
        {
          name = "Hack Nerd Font Mono";
          package = pkgs.hack-font;
        }
      ];
    };
  };
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
    packages = lib.mkDefault (with pkgs; [
      terminus_font
      powerline-fonts
    ]);
  };
}

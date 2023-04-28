{
  lib,
  pkgs,
  ...
}: {
  console = {
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
    packages = lib.mkDefault (with pkgs; [
      terminus_font
      powerline-fonts
    ]);
  };
}

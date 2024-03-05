{ pkgs, ... }: {
  console = {
    # { dell = 282; pc = 163; }."${config.networking.hostName}" or 144
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
    # font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz"; # dell
  };
}

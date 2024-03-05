{ pkgs, config, ... }: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-${if config.networking.hostName == "dell" then "v32n" else "v14n"}.psf.gz";
  };
}

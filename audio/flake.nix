# vim: nofoldenable
{
  inputs = {
    musnix.url = "github:musnix/musnix";
  };
  outputs =
    { ... }@inputs:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          imports = [
            inputs.musnix.nixosModules.musnix
          ];
          environment.systemPackages = with pkgs; [
            libbs2b
            ladspaPlugins
            lsof
            # vital
            # bitwig-studio
            mixxx
          ];
          # https://github.com/mixxxdj/mixxx/wiki/troubleshooting
          # environment.variables.QT_AUTO_SCREEN_SCALE_FACTOR = "0";
          # environment.variables.QT_FONT_DPI = "144";
          services.udev.packages = [
            pkgs.mixxx
            # pkgs.bitwig-studio
          ];
        };
    };
}

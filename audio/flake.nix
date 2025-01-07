# vim: nofoldenable
{
  inputs = {
    musnix.url = "github:musnix/musnix";
  };
  outputs =
    { ... }@inputs:
    {
      nixosModules.mpd = _: { imports = [ ./mpd.nix ]; };
      nixosModules.pipewire = _: { imports = [ ./pipewire.nix ]; };
      nixosModules.pulseaudio = _: { imports = [ ./pulseaudio.nix ]; };
      nixosModules.production =
        { pkgs, config, ... }:
        {
          # https://wiki.nixos.org/wiki/Audio_production
          # https://github.com/musnix/musnix
          imports = [
            inputs.musnix.nixosModules.musnix
          ];
          environment.systemPackages = with pkgs; [
            ardour
            libbs2b
            ladspaPlugins
            lsof
            vital
            distrho-ports
            lsp-plugins
            bitwig-studio
            mixxx
            yoshimi
            guitarix
            # muse
            infamousPlugins
            mamba
          ];
          # https://github.com/mixxxdj/mixxx/wiki/troubleshooting
          # environment.variables.QT_AUTO_SCREEN_SCALE_FACTOR = "0";
          environment.variables.QT_FONT_DPI = config.services.xserver.dpi;
          services.udev.packages = [
            pkgs.mixxx
            pkgs.bitwig-studio
          ];
        };
    };
}

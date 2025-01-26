# https://wiki.hyprland.org/
# https://github.com/Vladimir-csp/uwsm
{
  outputs =
    { ... }:
    {
      nixosModules = {
        default =
          { pkgs, ... }:
          {
            environment.variables.WAYLAND_DISPLAY = "wayland-0";
            programs.hyprland = {
              enable = true;
              withUWSM = true; # recommended for most users
              xwayland.enable = true; # Xwayland can be disabled.
            };
            programs.uwsm = {
              enable = true;
              waylandCompositors = {
                hyprland = {
                  prettyName = "Hyprland";
                  comment = "Hyprland compositor managed by UWSM";
                  binPath = "/run/current-system/sw/bin/Hyprland";
                };
                sway = {
                  prettyName = "Sway";
                  comment = "Sway compositor managed by UWSM";
                  binPath = "/run/current-system/sw/bin/sway";
                };
              };
            };

            programs.sway = {
              enable = true;
              wrapperFeatures.gtk = true;
            };
            environment.systemPackages = with pkgs; [
              util-linux
              newt
              fuzzel
              grim # screenshot functionality
              slurp # screenshot functionality
              wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
              mako # notification system developed by swaywm maintainer
            ];
          };
      };
    };
}

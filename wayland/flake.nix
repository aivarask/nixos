# vim: nofoldenable
{
  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

  };
  outputs =
    { ... }@inputs:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          programs.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
          };
          environment.systemPackages = with pkgs; [
            grim # screenshot functionality
            slurp # screenshot functionality
            wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
            mako # notification system developed by swaywm maintainer
          ];

          # Enable the gnome-keyring secrets vault.
          # Will be exposed through DBus to programs willing to store secrets.
          services.gnome.gnome-keyring.enable = true;
        };
      nixosModules.home =
        { pkgs, ... }:
        {
          wayland.windowManager.hyprland.settings = {
            env = [
              "WLR_DRM_DEVICES,/dev/dri/card0"
              "LIBVA_DRIVER_NAME,nvidia"
              "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            ];
            decoration = {
              shadow_offset = "0 5";
              "col.shadow" = "rgba(00000099)";
            };

            "$mod" = "SUPER";

            bindm = [
              # mouse movements
              "$mod, mouse:272, movewindow"
              "$mod, mouse:273, resizewindow"
              "$mod ALT, mouse:272, resizewindow"
            ];
          };
          wayland.windowManager.hyprland.plugins = [
            # pkgs.hyprlandPlugins.
            # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.PLUGIN_NAME
          ];

          programs.hyprland = {
            # https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf
            enable = true;
            withUWSM = true; # recommended for most users
            xwayland.enable = true;
            # set the flake package
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            # make sure to also set the portal package, so that they are in sync
            portalPackage =
              inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };

        };
    };
}

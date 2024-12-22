# vim: nofoldenable
{ pkgs, inputs, ... }:
{
  # environment.systemPackages = with pkgs; [ kitty ];
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
}

{ pkgs, ... }:
{
  environmentsystemPackages = with pkgs; [
    sway
    swaybg
    swayidle
    swaylock
    waybar
    foot
    grim
    slurp
    wl-copy
    wl-clipboard
    mako
    kanshi
    gammastep
    playerctl
    xdg-desktop-portal-wlr
    pipewire
    wireplumber
    pavucontrol
    polkit-gnome

  ];
  environment.variables = {
    WLR_DRM_NO_MODIFIERS = 1;
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "sway";
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";

  };
}

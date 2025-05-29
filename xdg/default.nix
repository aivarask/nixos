{ pkgs, ... }:
{
  # environment.variables.GTK_USE_PORTAL = "1";
  environment.systemPackages = with pkgs; [
    xdg-utils
    kdePackages.dolphin
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.kdePackages.xdg-desktop-portal-kde
  ];
  xdg.portal.config.common.default = "kde";

  # https://discourse.nixos.org/t/creating-symlinks-in-nixos/50280/3
  xdg.terminal-exec.enable = true;
  xdg.terminal-exec.settings.default = [ "kitty.desktop" ];
  environment.variables.XDG_TERMINAL = "${pkgs.kitty}/bin/kitty";
  environment.variables.XDG_SYSTEM_MONITOR = "${pkgs.resources}/bin/resources";

  xdg.mime.enable = true;
  # /etc/profiles/per-user/root/share/applications
  xdg.mime.defaultApplications = {
  };
  xdg.mime.removedAssociations = {
    "audio/mpeg" = [ "mpv.desktop" ];
    "audio/mp3" = [
      "mpv.desktop"
      "umpv.desktop"
    ];
    "inode/directory" = "codium.desktop";
  };
}

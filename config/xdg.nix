# vim: nofoldenable
{ pkgs, ... }:
{
  # environment.variables.GTK_USE_PORTAL = "1";
  environment.systemPackages = with pkgs; [
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    # pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-kde
  ];
  # xdg.portal.config.common.default = "gtk";
  xdg.portal.config.common.default = "kde";
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      # "text/html" = "nvim.desktop";
      "text/html" = "firefox.desktop";
      "text/css" = "nvim.desktop";
      "text/x-lua" = "nvim.desktop";
      "text/x-csrx" = "nvim.desktop";
      "text/x-php" = "nvim.desktop";
      "text/*" = "nvim.desktop";

      "application/pdf" = "firefox.desktop";
      "application/json" = "nvim.desktop";
      "application/sql" = "nvim.desktop";
      "application/javascript" = "nvim.desktop";
      "application/x-yaml" = "nvim.desktop";
      "application/x-shellscript" = "nvim.desktop";
      "application/x-*" = "nvim.desktop";
      "application/*" = "nvim.desktop";

      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/x-xdg-protocol-tg" = "telegram.desktop";
      "x-scheme-handler/tg" = "telegram.desktop";

      "image/*" = [
        "sxiv.desktop"
        "gimp.desktop"
      ];
      "text/vnd.trolltech.linguist" = "nvim.desktop";
    };
    removedAssociations = {
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/mp3" = [
        "mpv.desktop"
        "umpv.desktop"
      ];
      "inode/directory" = "codium.desktop";
    };
  };
}

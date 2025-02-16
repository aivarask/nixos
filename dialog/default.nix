{ pkgs, ... }:
{
  # https://wiki.archlinux.org/title/List_of_applications/Utilities#GUI/TUI_prompts
  environment.systemPackages = [
    pkgs.yad
    # https://help.gnome.org/users/zenity/stable/index.html.en
    pkgs.zenity
  ];
  # xprop | grep WM_CLASS
  # xprop | grep WM_NAME

}

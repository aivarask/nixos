{
  config,
  pkgs,
  SELF,
  xdgconf,
  inputs,
  lib,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  manual.json.enable = true;
  programs.man.generateCaches = true;
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.music = "${config.home.homeDirectory}/Music";
  xdg.userDirs.videos = "${config.home.homeDirectory}/Videos";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Pictures";
  home.file."Pictures/img".source = symlink "${SELF}/img";

  imports = [
    ./.config/bat/default.nix
    ./.config/chromium/default.nix
    ./.config/direnv/default.nix
    ./.config/eza/default.nix
    ./.config/firefox/default.nix
    ./.config/fzf/default.nix
    ./.config/git/default.nix
    ./.config/mpv/default.nix
    ./.config/ncmpcpp/default.nix
    ./.config/nicotine/default.nix
    ./.config/ripgrep/default.nix
    ./.config/starship/default.nix
    ./.config/zsh/default.nix
  ];

  home.packages = with pkgs; [
    inkscape-with-extensions
    lnav
    htop
    gtk3
    gtk4
    nautilus
    thunar
    tumbler
    kitty
    gtk-doc
    vimpager
    bitwarden-cli
    # bitwarden-desktop
    spotify
    ncspot
    lingot # guitar tuner
    mixxx
  ];

  xdg.configFile."lingot".source = symlink "${xdgconf}/lingot";
  xdg.configFile."Thunar".source = symlink "${xdgconf}/Thunar";
  xdg.configFile."alias".source = symlink "${xdgconf}/alias";
  xdg.configFile."ardour8".source = symlink "${xdgconf}/ardour8";
  xdg.configFile."clangd".source = symlink "${xdgconf}/clangd";
  xdg.configFile."fd".source = symlink "${xdgconf}/fd";
  xdg.configFile."flameshot".source = symlink "${xdgconf}/flameshot";
  xdg.configFile."foot".source = symlink "${xdgconf}/foot";
  xdg.configFile."gammastep".source = symlink "${xdgconf}/gammastep";
  xdg.configFile."gtk-2.0".source = symlink "${xdgconf}/gtk-2.0";
  xdg.configFile."gtk-3.0".source = symlink "${xdgconf}/gtk-3.0";
  xdg.configFile."gtk-4.0".source = symlink "${xdgconf}/gtk-4.0";
  xdg.configFile."htop".source = symlink "${xdgconf}/htop";
  xdg.configFile."inkscape".source = symlink "${xdgconf}/inkscape";
  xdg.configFile."kitty".source = symlink "${xdgconf}/kitty";
  xdg.configFile."lazygit".source = symlink "${xdgconf}/lazygit";
  xdg.configFile."lf".source = symlink "${xdgconf}/lf";
  xdg.configFile."lnav".source = symlink "${xdgconf}/lnav";
  xdg.configFile."mimeapps.list".source = symlink "${xdgconf}/mimeapps.list";
  xdg.configFile."ncspot".source = symlink "${xdgconf}/ncspot";
  xdg.configFile."pipewire".source = symlink "${xdgconf}/pipewire";
  xdg.configFile."pistol".source = symlink "${xdgconf}/pistol";
  xdg.configFile."rofi".source = symlink "${xdgconf}/rofi";
  xdg.configFile."shellcheckrc".source = symlink "${xdgconf}/shellcheckrc";
  xdg.configFile."spotify-flags.conf".source = symlink "${xdgconf}/spotify-flags.conf";
  xdg.configFile."sqlite3".source = symlink "${xdgconf}/sqlite3";
  xdg.configFile."stylua".source = symlink "${xdgconf}/stylua";
  xdg.configFile."sway".source = symlink "${SELF}/sway";
  xdg.configFile."taplo".source = symlink "${xdgconf}/taplo";
  xdg.configFile."tmux".source = symlink "${xdgconf}/tmux";
  xdg.configFile."user-dirs.dirs".source = symlink "${xdgconf}/user-dirs.dirs";
  xdg.configFile."user-dirs.locale".source = symlink "${xdgconf}/user-dirs.locale";
  xdg.configFile."waybar".source = symlink "${SELF}/sway/waybar";
  xdg.configFile."zathura".source = symlink "${xdgconf}/zathura";
}

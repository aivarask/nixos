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
  home.enableNixpkgsReleaseCheck = false;

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.music = "${config.home.homeDirectory}/Music";
  xdg.userDirs.videos = "${config.home.homeDirectory}/Videos";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Pictures";
  home.file."Pictures/img".source = symlink "${SELF}/img";

  imports = [
    ./.config/chromium/default.nix
    ./.config/firefox/default.nix
    ./.config/zsh/default.nix
    ./.config/git/default.nix
    ./.config/mpv/default.nix
  ];

  home.packages = with pkgs; [
    lnav
    htop
    lf # https://github.com/gokcehan/lf
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
    nicotine-plus
    spotify
    ncspot
    celluloid
    dav1d
    udiskie
  ];
  xdg.configFile."flameshot".source = symlink "${xdgconf}/flameshot";
  xdg.configFile."rofi".source = symlink "${xdgconf}/rofi";
  xdg.configFile."Thunar".source = symlink "${xdgconf}/Thunar";
  xdg.configFile."pipewire".source = symlink "${xdgconf}/pipewire";
  xdg.configFile."gammastep".source = symlink "${xdgconf}/gammastep";
  xdg.configFile."kitty".source = symlink "${xdgconf}/kitty";
  xdg.configFile."shellcheckrc".source = symlink "${xdgconf}/shellcheckrc";
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.enableZshIntegration = true;
  # home.file.".mixxx".source = symlink "/etc/nixos/.mixxx";
  home.file.".alias".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.alias";
  xdg.configFile."ardour8".source = symlink "${xdgconf}/ardour8";
  xdg.configFile."bat".source = symlink "${xdgconf}/bat";
  programs.bat.enable = true;
  programs.bat.extraPackages = with pkgs.bat-extras; [
    batgrep
    batman
    batpipe
    batwatch
    batdiff
    prettybat
  ];
  xdg.configFile."ripgrep".source = symlink "${xdgconf}/ripgrep";
  xdg.configFile."tmux".source = symlink "${xdgconf}/tmux";
  xdg.configFile."mimeapps.list".source = symlink "${xdgconf}/mimeapps.list";
  xdg.configFile."user-dirs.dirs".source = symlink "${xdgconf}/user-dirs.dirs";
  xdg.configFile."user-dirs.locale".source = symlink "${xdgconf}/user-dirs.locale";
  xdg.configFile."sqlite3".source = symlink "${xdgconf}/sqlite3";
  xdg.configFile."zathura".source = symlink "${xdgconf}/zathura";
  xdg.configFile."inkscape".source = symlink "${xdgconf}/inkscape";
  xdg.configFile."spotify-flags.conf".source = symlink "${xdgconf}/spotify-flags.conf";
  xdg.configFile."ncspot".source = symlink "${xdgconf}/ncspot";
  xdg.configFile."wlr-which-key/config.yaml".source = symlink "${xdgconf}/wlr-which-key/config.yaml";
  xdg.configFile."sway".source = symlink "${SELF}/sway";
  # home.file.".sway".source = symlink "${SELF}/sway";
  xdg.configFile."waybar".source = symlink "${SELF}/sway/waybar";
  xdg.configFile."foot".source = symlink "${xdgconf}/foot";
  xdg.configFile."gtk-2.0".source = symlink "${xdgconf}/gtk-2.0";
  xdg.configFile."gtk-3.0".source = symlink "${xdgconf}/gtk-3.0";
  xdg.configFile."gtk-4.0".source = symlink "${xdgconf}/gtk-4.0";
  xdg.configFile."htop".source = symlink "${xdgconf}/htop";
  xdg.configFile."lf".source = symlink "${xdgconf}/lf";
  xdg.configFile."lnav".source = symlink "${xdgconf}/lnav";
  xdg.configFile."lazygit".source = symlink "${xdgconf}/lazygit";

  xdg.configFile."starship.toml".source = symlink "${xdgconf}/starship.toml";
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;

  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp/config" = {
    source = symlink "${xdgconf}/ncmpcpp/config";
    enable = true;
    force = true;
  };
  xdg.configFile."ncmpcpp/bindings" = {
    source = symlink "${xdgconf}/ncmpcpp/bindings";
    enable = true;
    force = true;
  };

  programs.pistol.enable = true; # https://github.com/doronbehar/pistol
  xdg.configFile."pistol".source = symlink "${xdgconf}/pistol";

  xdg.configFile."nicotine" = {
    source = symlink "${xdgconf}/nicotine";
    enable = true;
    force = true;
    recursive = true;
    # onChange = ''
    # '';
  };

  programs.eza.enable = true;
  programs.eza.icons = "auto";
  programs.eza.enableZshIntegration = false;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config.load_dotenv = true;
  programs.direnv.enableBashIntegration = true;
  programs.direnv.enableZshIntegration = true;

  # xdg.configFile."udiskie".source = symlink "${xdgconf}/udiskie";
  # services.udiskie.enable = true;
}

{
  config,
  pkgs,
  SELF,
  xdgconf,
  inputs,
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
  home.file."${config.xdg.userDirs.pictures}/img".source = symlink "${SELF}/img";
  xdg.userDirs.extraConfig = {
    MISC = "${config.home.homeDirectory}/Misc";
  };

  imports = [
    {
      home.packages = with pkgs; [
        reaper
        surge-xt
        vital
      ];
    }
    ./.config/bat/default.nix
    ./.config/chromium/default.nix
    ./.config/direnv/default.nix
    ./.config/eza/default.nix
    ./firefox/default.nix
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
    xdg-terminal-exec
    xdg-launch
    sqlitebrowser
    gcr
    inkscape-with-extensions
    lnav
    htop
    gtk3
    gtk4
    nautilus
    thunar
    thunar-volman
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
    #################### from sway
    clipman
    mcat
    keyd
    wshowkeys
    libinput
    # sway-overfocus
    showmethekey
    fuzzel
    x11perf
    waypipe
    ydotool
    hyprmagnifier
    bemoji
    catt
    eww
    gammastep
    glib-networking
    grim
    ifwifi
    kanshi
    localsend
    # mako
    miraclecast
    papirus-icon-theme
    pavucontrol
    pipewire
    playerctl
    python3
    kdotool

    # internet speed
    ookla-speedtest
    # speedtest-cli
    iperf3
    traceroute

    # sway
    swayidle
    swaylock
    swayr
    waybar
    wayvnc
    wdisplays
    wev
    wtype
    evtest
    # wireplumber
    wl-clipboard
    wlr-randr
    wttrbar
    xcursor-pro
    xdg-utils # https://www.freedesktop.org/wiki/Software/xdg-utils/
    xdg-terminal-exec
    xdg-user-dirs
    xdg-user-dirs-gtk
    # xdg-desktop-portal-wlr
    xkeyboard-config
    xkbcomp
    xmodmap
    setxkbmap
    # https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#bar-content-generators

  ];
  xdg.dataFile."nwg-dock/images/grid.svg".source = "${pkgs.nwg-dock-hyprland.out}/images/grid.svg";
  # symlink "/run/current-system/sw/share/icons/Papirus/96x96/apps";
  home.file.".inputrc".source = symlink "${SELF}/.inputrc";
  # https://catonmat.net/bash-vi-editing-mode-cheat-sheet

  xdg.configFile."lingot".source = symlink "${xdgconf}/lingot";
  xdg.configFile."Thunar".source = symlink "${xdgconf}/Thunar";
  xdg.configFile."alias".source = symlink "${xdgconf}/alias";
  xdg.configFile."clangd".source = symlink "${xdgconf}/clangd";
  xdg.configFile."fd".source = symlink "${xdgconf}/fd";
  xdg.configFile."flameshot".source = symlink "${xdgconf}/flameshot";
  xdg.configFile."foot".source = symlink "${xdgconf}/foot";
  xdg.configFile."fuzzel".source = symlink "${xdgconf}/fuzzel";
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
  xdg.configFile."niri/config.kdl".source = symlink "${SELF}/niri.kdl";
  xdg.configFile."niri/binds.kdl".source = symlink "${SELF}/niri_binds.kdl";
  xdg.configFile."niri-session-manager/config.toml".source = symlink "${SELF}/nirisess.toml";
  xdg.configFile."nwg-dock".source = symlink "${xdgconf}/nwg-dock";
  xdg.configFile."nwg-bar".source = symlink "${xdgconf}/nwg-bar";
  xdg.configFile."ncspot".source = symlink "${xdgconf}/ncspot";
  xdg.configFile."pipewire".source = symlink "${xdgconf}/pipewire";
  xdg.configFile."pistol".source = symlink "${xdgconf}/pistol";
  xdg.configFile."shellcheckrc".source = symlink "${xdgconf}/shellcheckrc";
  xdg.configFile."spotify-flags.conf".source = symlink "${xdgconf}/spotify-flags.conf";
  xdg.configFile."sqlite3".source = symlink "${xdgconf}/sqlite3";
  xdg.configFile."stylua".source = symlink "${xdgconf}/stylua";
  xdg.configFile."sway/config".source = symlink "${SELF}/sway.config";
  xdg.configFile."taplo".source = symlink "${xdgconf}/taplo";
  xdg.configFile."tmux".source = symlink "${xdgconf}/tmux";
  xdg.configFile."user-dirs.dirs".source = symlink "${xdgconf}/user-dirs.dirs";
  xdg.configFile."user-dirs.locale".source = symlink "${xdgconf}/user-dirs.locale";
  xdg.configFile."waybar".source = symlink "${SELF}/waybar";
  xdg.configFile."zathura".source = symlink "${xdgconf}/zathura";
  xdg.configFile."w3m".source = symlink "${xdgconf}/w3m";
  xdg.configFile."wluma".source = symlink "${xdgconf}/wluma";
  xdg.configFile."xdg-terminals.list".source = symlink "${xdgconf}/xdg-terminals.list";
}

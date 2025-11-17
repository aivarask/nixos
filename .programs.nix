{
  config,
  pkgs,
  SELF,
  ...
}:

{
  imports = [
    (
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          git
          git-lfs
          gh
          git-crypt
          pre-commit
          delta
          lazygit
          difftastic
          diff-so-fancy
          python3Packages.ydiff
          patchutils
        ];
        programs.git.enable = true;
        # programs.git.package = pkgs.gitFull;
        programs.git.lfs.enable = true;
        programs.git.maintenance.enable = true;
        programs.git.settings = {
          include.path = [
            "/etc/nixos/.config/git/config_global"
            "/etc/nixos/.copfig/git/config_user"
          ];
        };
      }
    )
  ];

  home.packages = with pkgs; [
    lnav # lnav_='lnav -I /etc/nixos/prog_/ /var/log/Xorg.0.log $XDG_STATE_HOME/nvim/*.log'\
    htop
    lf
    gtk3
    gtk4
    gtk-doc
    vimpager
    ncspot
    # bitwarden-cli
    # bitwarden
    # bitwarden-desktop
    nicotine-plus
  ];
  # home.file.".ripgreprc".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.ripgreprc";
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.enableZshIntegration = true;
  # home.file.".mixxx".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.mixxx";
  xdg.configFile."ardour8".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/ardour8";
  xdg.configFile."bat".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.config/bat";
  programs.bat.enable = true;
  programs.bat.extraPackages = with pkgs.bat-extras; [
    batgrep
    batman
    batpipe
    batwatch
    batdiff
    prettybat
  ];
  xdg.configFile."sqlite3".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/sqlite3";
  xdg.configFile."spotify-flags.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/spotify-flags.conf";
  xdg.configFile."ncspot".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/ncspot";
  xdg.configFile."sway".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sway";
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sway/waybar";
  xdg.configFile."foot".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/foot";
  xdg.configFile."gtk-3.0".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/./config/gtk-3.0";
  xdg.configFile."gtk-4.0".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/gtk-4.0";
  xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/htop";
  xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/lf";
  xdg.configFile."lnav".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/lnav";
  xdg.configFile."lazygit".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/lazygit";
  xdg.configFile."git/config_global".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/git/config_global";
  xdg.configFile."git/config_user".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/git/config_user";
  xdg.configFile."git/ignore".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/git/ignore";

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      package.disabled = true;
      golang.disabled = true;
      lua.disabled = true;
      nodejs.disabled = true;
      php.disabled = true;
      rust.disabled = true;
    };
  };

  xdg.configFile."mpv".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/mpv";
  programs.mpv.enable = true;
  programs.mpv.package = (
    pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        waylandSupport = true;
      };
      scripts = with pkgs.mpvScripts; [
        pkgs.mpvScripts.uosc # https://github.com/tomasklaen/uosc
        pkgs.mpvScripts.reload # https://github.com/4e6/mpv-reload
      ];
    }
  );
  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp/config" = {
    enable = true;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp/config";
  };
  xdg.configFile."ncmpcpp/bindings" = {
    enable = true;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp/bindings";
  };

  programs.pistol.enable = true; # https://github.com/doronbehar/pistol
  xdg.configFile."pistol".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/.config/pistol";

  xdg.configFile."nicotine" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/nicotine";
    enable = true;
    force = true;
    recursive = true;
    # onChange = ''
    #   cat ${config.home.homeDirectory}/.config/nicotine/config_def > ${config.home.homeDirectory}/.config/nicotine/config
    # '';
  };
}

{
  config,
  pkgs,
  SELF,
  ...
}:
let
  xdgconf = "${SELF}/.config";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
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
            "${xdgconf}/git/config_global"
            "${xdgconf}/git/config_user"
          ];
        };
      }
    )
    (
      { pkgs, ... }:
      {
        # https://github.com/rothgar/mastering-zsh
        home.packages = with pkgs; [
          bash-language-server
          shellcheck
          shfmt
          dotenv-linter
          shellharden
        ];
        programs.zsh.autocd = true;
        programs.zsh.syntaxHighlighting.enable = true;
        programs.zsh.autosuggestion.enable = false;
        # programs.zsh.dotDir = ".config/zsh";
        programs.zsh.history.size = 10000;
        programs.zsh.history.extended = true;
        programs.zsh.plugins = [
          {
            name = "zsh-autocomplete";
            src = pkgs.zsh-autocomplete;
            file = "share/zsh-autocomplete/zsh-autocomplete.zsh";
          }

          #https://github.com/agkozak/zhooks
          # {
          #   name = "vi-mode";
          #   src = pkgs.zsh-vi-mode; # https://github.com/jeffreytse/zsh-vi-mode
          #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          # }
          # {
          #   name = "system-clipboard";
          #   src = pkgs.zsh-system-clipboard; # https://github.com/kutsan/zsh-system-clipboard
          #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
          # }
        ];

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
    # bitwarden-cli
    # bitwarden
    # bitwarden-desktop
    nicotine-plus
    spotify
    ncspot
  ];
  home.file.".ripgreprc".source = symlink "${config.home.homeDirectory}/.ripgreprc";
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.enableZshIntegration = true;
  # home.file.".mixxx".source = symlink "/etc/nixos/.mixxx";
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
  xdg.configFile."sqlite3".source = symlink "${xdgconf}/sqlite3";
  xdg.configFile."spotify-flags.conf".source = symlink "${xdgconf}/spotify-flags.conf";
  xdg.configFile."ncspot".source = symlink "${xdgconf}/ncspot";
  xdg.configFile."sway".source = symlink "${SELF}/sway";
  # xdg.configFile."sway".source = symlink "${xdgconf}/sway";
  xdg.configFile."waybar".source = symlink "${SELF}/waybar";
  # xdg.configFile."waybar".source = symlink "${xdgconf}/waybar";
  xdg.configFile."foot".source = symlink "${xdgconf}/foot";
  xdg.configFile."gtk-3.0".source = symlink "${xdgconf}/gtk-3.0";
  xdg.configFile."gtk-4.0".source = symlink "${xdgconf}/gtk-4.0";
  xdg.configFile."htop".source = symlink "${xdgconf}/htop";
  xdg.configFile."lf".source = symlink "${xdgconf}/lf";
  xdg.configFile."lnav".source = symlink "${xdgconf}/lnav";
  xdg.configFile."lazygit".source = symlink "${xdgconf}/lazygit";
  xdg.configFile."git/config_global".source = symlink "${xdgconf}/git/config_global";
  xdg.configFile."git/config_user".source = symlink "${xdgconf}/git/config_user";
  xdg.configFile."git/ignore".source = symlink "${xdgconf}/git/ignore";

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = symlink "${xdgconf}/starship.toml";
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;

  xdg.configFile."mpv".source = symlink "${xdgconf}/mpv";
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
    source = symlink "${xdgconf}/ncmpcpp/config";
  };
  xdg.configFile."ncmpcpp/bindings" = {
    enable = true;
    force = true;
    source = symlink "${xdgconf}/ncmpcpp/bindings";
  };

  programs.pistol.enable = true; # https://github.com/doronbehar/pistol
  xdg.configFile."pistol".source = symlink "${xdgconf}/pistol";

  xdg.configFile."nicotine" = {
    source = symlink "${xdgconf}/nicotine";
    enable = true;
    force = true;
    recursive = true;
    # onChange = ''
    #   cat ${config.home.homeDirectory}/.config/nicotine/config_def > ${config.home.homeDirectory}/.config/nicotine/config
    # '';
  };

  programs.eza.enable = true;
  programs.eza.icons = "auto";
  programs.eza.enableZshIntegration = false;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.config = {
    load_dotenv = true;
  };
  programs.direnv.enableBashIntegration = true;
  programs.direnv.enableZshIntegration = true;

  programs.gh.enable = true;
  programs.gh.extensions = with pkgs; [
    gh-eco
    # gh-poi
    # gh-dash
    # gh-actions-cache
    gh-markdown-preview
  ];
  programs.gh.settings = {
    git_protocol = "ssh";
    prompt = "enabled";
    aliases = {
      co = "pr checkout";
      pv = "pr view";
    };
  };
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = true;
}

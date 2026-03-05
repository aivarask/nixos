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
    ./.config/chromium/default.nix
    ./.config/firefox/default.nix
    ./.config/zsh/default.nix
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
  ];

  home.packages = with pkgs; [
    lnav
    htop
    lf # https://github.com/gokcehan/lf
    gtk3
    gtk4
    xdg-utils # https://www.freedesktop.org/wiki/Software/xdg-utils/
    nautilus
    thunar
    tumbler
    kitty
    gtk-doc
    vimpager
    bitwarden-cli
    bitwarden-desktop
    nicotine-plus
    spotify
    ncspot
  ];
  xdg.configFile."gammastep".source = symlink "${xdgconf}/gammastep";
  xdg.configFile."kitty".source = symlink "${xdgconf}/kitty";
  xdg.configFile."espanso".source = symlink "${xdgconf}/espanso";
  xdg.configFile."ripgreprc".source = symlink "${xdgconf}/ripgreprc";
  xdg.configFile."shellcheckrc".source = symlink "${xdgconf}/shellcheckrc";
  programs.ripgrep.enable = true;
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
    pkgs.mpv.override {
      # mpv = pkgs.mpv.override {
      #   waylandSupport = true;
      # };
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
}

{ pkgs, ... }: {
  environment = {
    profiles = [
      # $NIX_PROFILES
      # "/etc/nixos"
      "${pkgs.zsh-completions}"
    ];
    variables = {
      EDITOR = "nvim";
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
      QT_AUTO_SCREEN_SET_FACTOR = "0";
      QT_SCALE_FACTOR = "1";
      QT_FONT_DPI = "144";
      XINITRC = "/etc/nixos/xinitrc";
      # XSERVERRC = "/etc/X11/xinit/xserverrc";
    };
    shellAliases = {
      ep = "echo $PATH | tr ':' '\n'";
      codium = "codium --no-sandbox --user-data-dir ~/.codium";
      wol_pc = "wol b4:2e:99:61:09:cf";
      ".." = "cd ..";
      "..." = "../..";
      l = "ls -l --group-directories-first";
      la = "ls -la";
      lg = "lazygit";
      ls = "eza --icons --git";
      lt = "ls --tree --level=2";
      oras = "curl wttr.in/Vilnius";
      tre = "trans :en";
      trl = "trans :lt";
      x = "startx";
      xs = "xinit $XINITRC -- $XSERVERRC";
      xa = "startx $XINITRC awesome";
    };
    sessionVariables = rec {
      # https://nixos.wiki/wiki/Environment_variables
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_BIN_HOME = "$HOME/.local/bin";

      PATH = [
        "${XDG_BIN_HOME}"
        "/etc/nixos/bin"
      ];

    };
  };
}

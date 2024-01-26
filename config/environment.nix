{ pkgs, ... }: {
  environment = {
    profiles = [
      # $NIX_PROFILES
      # "/etc/nixos"
    ];
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      editor = "vim";
      PNPM_HOME = "$HOME/.pnpm-global";
      NPM_CONFIG_PREFIX = "$HOME/.node_modules";
      NODE_OPTIONS = "--no-warnings";
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
      QT_AUTO_SCREEN_SET_FACTOR = "0";
      QT_SCALE_FACTOR = "1";
      QT_FONT_DPI = "144";
      XINITRC = "/etc/nixos/home/files/xinitrc";
      # XSERVERRC = "/etc/X11/xinit/xserverrc";
    };
    shellAliases = {
      pm = "pulsemixer";
      codium = "codium --no-sandbox --user-data-dir ~/.codium";
      nf = "nvim -c 'Files'";
      ng = "nvim -c 'Rg'";
      nt = "nvim -c 'Telescope'";
      brave = "brave --no-sandbox --enable-features=TouchpadOverscrollHistoryNavigation";
      wol_pc = "wol b4:2e:99:61:09:cf";
      ".." = "cd ..";
      "..." = "../..";
      l = "ls -l --group-directories-first";
      la = "ls -la";
      lg = "lazygit";
      ls = "eza --icons --git";
      lt = "ls --tree --level=2";
      mc = "tmux split -h lf; lf";
      mcd = "tmux split -h nd; ndcw; ndtw";
      oras = "curl wttr.in/Vilnius";
      pn = "pnpm";
      tre = "trans :en";
      trl = "trans :lt";
      x = "startx";
      xs = "xinit $XINITRC -- $XSERVERRC";
      xa = "startx $XINITRC awesome";
    };
  };
}

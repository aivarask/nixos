{pkgs, ...}: {
  imports = [./LF_ICONS.nix];
  # https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/nixos/modules/config/shells-environment.nix
  environment = {
    profiles = [
      "${pkgs.zsh-completions}"
      "/etc/nixos"
    ];
    variables = {
      BAT_THEME = "gruvbox-dark";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      editor = "vim";
      # MANPAGER = modules/misc/documentation.nix
      # MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      PNPM_HOME = "$HOME/.pnpm-global";
      NPM_CONFIG_PREFIX = "$HOME/.node_modules";
      # NODE_OPTIONS = "--loader ts-node/esm --experimental-specifier-resolution=node --no-warnings";
      NODE_OPTIONS = "--no-warnings";
      # PRISMA_FMT_BINARY = "${pkgs.prisma-engines}/bin/prisma-fmt";
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      # PRISMA_MIGRATION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/migration-engine";
      # PRISMA_INTROSPECTION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/introspection-engine";
      # PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING = 1;
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
      QT_AUTO_SCREEN_SET_FACTOR = "0";
      QT_SCALE_FACTOR = "1";
      QT_FONT_DPI = "144";
      XINITRC = "/etc/nixos/home/files/xinitrc";
      # XSERVERRC = "/etc/X11/xinit/xserverrc";
    };
    shellAliases = {
      wp = "wp --allow-root";
      less = "batpipe"; # https://github.com/eth-p/bat-extras/blob/master/doc/batpipe.md
      man = "batman"; # https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
      codium = "codium --no-sandbox --user-data-dir ~/.codium";
      nf = "nvim -c 'Files'";
      ng = "nvim -c 'Rg'";
      nt = "nvim -c 'Telescope'";
      nfu = "nix flake update";
      nflu = "nix flake lock --update-input";
      nfluv = "nix flake lock --update-input vim";
      puppeteer = "puppeteer --no-sandbox";
      mmdc = "mmdc -p /etc/nixos/puppeteerConfigFile.json";
      brave = "brave --no-sandbox --enable-features=TouchpadOverscrollHistoryNavigation";
      wol_pc = "wol b4:2e:99:61:09:cf";
      ".." = "cd ..";
      "..." = "../..";
      "colored-tree" = "${pkgs.tree}/bin/tree -C";
      bp = "bat package.json";
      da = "direnv allow";
      dr = "direnv reload";
      l = "ls -l --group-directories-first";
      la = "ls -la";
      lg = "lazygit";
      ls = "eza --icons --git";
      lt = "ls --tree --level=2";
      lt3 = "ls --tree --level=3";
      mc = "tmux split -h lf; lf";
      mcd = "tmux split -h nd; ndcw; ndtw";
      oras = "curl wttr.in/Vilnius";
      pn = "pnpm";
      tre = "trans :en";
      trl = "trans :lt";
      up = "nixos-rebuild switch";
      uph = "nixos-rebuild switch && /etc/nixos/post-build-hook.sh";
      x = "startx";
      xs = "xinit $XINITRC -- $XSERVERRC";
      xa = "startx $XINITRC awesome";
    };
  };
}

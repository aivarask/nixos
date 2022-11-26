{ config, pkgs, ... }: {
  environment.sessionVariables = {
    # NIX_PATH = "$NIX_PATH:nixpkgs-overlays=/etc/nixos/overlays";
    PATH = [
      "/etc/nixos/bin"
      "$HOME/.pnpm-global"
      "$HOME/.node_modules/bin"
      "$HOME/.config/composer/vendor/bin"
    ];
  };
  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "../..";
    "colored-tree" = "${pkgs.tree}/bin/tree -C";
    bp = "bat package.json";
    chromium = "chromium --no-sandbox";
    brave = "brave --no-sandbox";
    da = "direnv allow";
    dr = "direnv reload";
    l = "ls -l --group-directories-first";
    la = "ls -la";
    lg = "lazygit";
    ls = "exa --icons --git";
    lt = "ls --tree --level=2";
    lt3 = "ls --tree --level=3";
    mc = "tmux split -h lf; lf";
    mcd = "tmux split -h nd; ndcw; ndtw";
    nd = "npm run dev";
    ndh = "npm run dev -- --host";
    ndo = "npm run dev -- --open";
    npa = "npm run pa";
    nrb = "npm run build";
    nrd = "npm run deploy";
    nrc = "npm run check";
    nrcw = "npm run check:watch";
    nrp = "npm run preview";
    nrpo = "npm run preview -- --open";
    nrpr = "npm run prepare";
    nrr = "npm run run";
    nrs = "npm run start";
    nrt = "npm run test";
    nrtd = "npm run test:dev";
    nrtu = "npm run test:unit";
    nrtw = "npm run test:watch";
    nsb = "npm run storybook";
    oras = "curl wttr.in/Vilnius";
    pdp = "prisma db push";
    pdr = "prisma db push --accept-data-loss --force-reset";
    pds = "prisma db seed";
    pg = "prisma generate";
    pn = "pnpm";
    tre = "trans :en";
    trl = "trans :lt";
    up = "nixos-rebuild switch";
    upb = "nixos-rebuild build";
    upt = "nixos-rebuild test";
    x = "startx";
  };
  environment.variables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
    editor = "vim";
    BROWSER = "firefox";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    PNPM_HOME = "$HOME/.pnpm-global";
    NPM_CONFIG_PREFIX = "$HOME/.node_modules";
    # NODE_OPTIONS = "--loader ts-node/esm --experimental-specifier-resolution=node --no-warnings";
    NODE_OPTIONS = "--no-warnings";
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
    PRISMA_MIGRATION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/migration-engine";
    PRISMA_INTROSPECTION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/introspection-engine";
    PRISMA_FMT_BINARY = "${pkgs.prisma-engines}/bin/prisma-fmt";
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    QT_AUTO_SCREEN_SET_FACTOR = "0";
    QT_SCALE_FACTOR = "1";
    QT_FONT_DPI = "144";
  };
}

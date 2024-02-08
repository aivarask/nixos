{ pkgs, ... }: {
  environment.systemPackages =
    with pkgs; [
      nodejs_21
      eslint_d
    ]
    ++ (with pkgs.nodePackages_latest; [
      pnpm # ~/.pnpm-global
      serve
      pm2
      dotenv-cli
    ]);
}

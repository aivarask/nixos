{ pkgs, ... }: {
  environment.systemPackages =
    with pkgs; [
      nodejs_21
      eslint_d
    ]
    ++ (with pkgs.nodePackages; [
      pnpm # ~/.pnpm-global
      serve
      pm2
      dotenv-cli
    ]);
}

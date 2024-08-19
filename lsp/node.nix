{ pkgs, ... }: {
  environment.variables = {
    NODE_OPTIONS = "--no-warnings";
    PNPM_HOME = "$HOME/.pnpm-global";

  };
  environment.sessionVariables = {
    PATH = [
      "$HOME/.pnpm-global"
      "$HOME/.npm/bin"
    ];
  };
  environment.systemPackages =
    with pkgs; [
      nodejs_22
      corepack_22
      eslint_d
      biome
      typescript
    ]
    ++ (with pkgs.nodePackages; [
      pnpm # ~/.pnpm-global
      serve
      pm2
      dotenv-cli
      prettierd
      typescript-language-server
      jsdoc
    ]);
}

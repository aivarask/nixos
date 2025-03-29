{
  inputs = { };
  outputs =
    { ... }:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.sessionVariables = rec {
            NODE_OPTIONS = "--no-warnings";
            PNPM_HOME = "$HOME/.pnpm";
            VSCODE_JS_DEBUG = "${pkgs.vscode-js-debug.outPath}";
            PATH = [
              "${PNPM_HOME}"
              "$HOME/.npm/bin"
            ];
          };
          environment.systemPackages =
            with pkgs;
            [
              nodejs_22
              corepack_22
              eslint_d
              # typescript
              vscode-js-debug
              stylelint-lsp
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
        };
    };
}

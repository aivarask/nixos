{ pkgs, ... }:
rec {
  home.sessionVariables = {
    NODE_OPTIONS = "--no-warnings";
    PNPM_HOME = "$HOME/.pnpm";
    VSCODE_JS_DEBUG = "${pkgs.vscode-js-debug.outPath}";
  };
  home.sessionPath = [
    "${home.sessionVariables.PNPM_HOME}"
    "$HOME/.npm/bin"
  ];
  home.packages =
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
      # typescript-language-server
      jsdoc
    ]);
}

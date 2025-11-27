{ pkgs, ... }:
{
  programs.npm = {
    enable = true;
    npmrc = ''
      		prefix = ''${HOME}/.npm
      		color=true
      							'';
  };
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
      puppeteer-cli
      pnpm # ~/.pnpm-global
      serve
      pm2
      dotenv-cli
      prettierd
      typescript-language-server
      jsdoc
    ]);

}

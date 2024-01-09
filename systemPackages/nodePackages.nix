{ pkgs, ... }: {
  environment.systemPackages =
    [
      pkgs.nodejs_20
    ]
    ++ (with pkgs.nodePackages_latest; [
      # ~/.pnpm-global
      pnpm

      # --
      jsdoc
      vscode-langservers-extracted
      dotenv-cli
      bash-language-server
      # coc-rust-analyzer
      degit
      diagnostic-languageserver
      emoj
      eslint
      eslint_d
      fixjson
      gulp
      js-beautify
      markdownlint-cli
      # node2nix
      # nodemon
      npm
      patch-package
      pm2
      serve
      speed-test
      stylelint
      # ts-node
      typescript
      typescript-language-server
      write-good
      yaml-language-server
    ]);
}

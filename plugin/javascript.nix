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
      dotenv-cli
      bash-language-server
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
    ]);
}

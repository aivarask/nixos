{pkgs, ...}: {
  environment.systemPackages =
    [
      pkgs.nodejs_20
    ]
    ++ (with pkgs.nodePackages_latest; [
      # ~/.pnpm-global
      # @prisma/language-server
      # @tailwindcss/language-server
      # c8
      # chokidar-cli
      # cssmodules-language-server
      # emmet-ls
      # stylelint-lsp
      # svelte-language-server
      pnpm

      # NOT IN USE
      # vercel
      # vscode-css-languageserver-bin
      # svelte-check

      # --
      jsdoc
      vscode-langservers-extracted
      dotenv-cli
      bash-language-server
      coc-rust-analyzer
      degit
      diagnostic-languageserver
      emoj
      eslint
      eslint_d
      # fast-cli # Test your download and upload speed using fast.com
      fixjson
      gulp
      js-beautify
      markdownlint-cli
      mermaid-cli
      # node2nix
      nodemon
      npm
      npm-check-updates
      patch-package
      pm2
      prettier
      prisma
      serve
      speed-test
      stylelint
      tailwindcss
      ts-node
      typescript
      typescript-language-server
      vim-language-server
      write-good
      yaml-language-server
    ]);
}

{pkgs, ...}: {
  environment.systemPackages =
    [
      pkgs.nodejs_20
    ]
    ++ (with pkgs.nodePackages_latest; [
      # emmet_ls
      # pnpm
      # vercel
      # vscode-css-languageserver-bin
      # vscode-langservers-extracted
      # --
      bash-language-server
      coc-rust-analyzer
      degit
      diagnostic-languageserver
      emoj
      eslint
      eslint_d
      fast-cli
      fixjson
      gulp
      js-beautify
      markdownlint-cli
      mermaid-cli
      mermaid-cli
      node2nix
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
      svelte-check
      svelte-language-server
      tailwindcss
      ts-node
      typescript
      typescript-language-server
      vim-language-server
      write-good
      yaml-language-server
    ]);
}

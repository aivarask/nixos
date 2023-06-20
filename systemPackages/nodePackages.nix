{pkgs, ...}: {
  environment.systemPackages =
    [
      pkgs.nodejs_20
    ]
    ++ (with pkgs.nodePackages_latest; [
      # emmet_ls
      mermaid-cli
      gulp
      npm
      bash-language-server
      vercel
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
      node2nix
      nodemon
      npm-check-updates
      patch-package
      pm2
      # pnpm
      prettier
      prettier_d_slim
      prisma
      serve
      speed-test
      stylelint
      svelte-check
      svelte-language-server
      tailwindcss
      typescript
      typescript-language-server
      vim-language-server
      # vscode-langservers-extracted
      yaml-language-server
      write-good
      ts-node
    ]);
}

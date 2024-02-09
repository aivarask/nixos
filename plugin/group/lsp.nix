{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    none-ls-nvim

    nvim-lsp-file-operations
    refactoring-nvim
    lsp_signature-nvim
    lsp-overloads-nvim
  ];
}

{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    refactoring-nvim
    lsp_signature-nvim
    lsp-overloads-nvim
    { plugin = nvim-lsp-file-operations; type = "lua"; config = "require('lsp-file-operations').setup({ debug = false })"; }
    none-ls-nvim
    SchemaStore-nvim
  ];
}

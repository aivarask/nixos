{ pkgs, ... }:
{
  programs.neovim.plugins = (
    with pkgs.vimPlugins;
    [
      one-small-step-for-vimkind
      nvim-lsp-file-operations
      neotest-playwright
      persistent-breakpoints
      smart-semicolon
      tree-sitter-language-injection
      websocket-nvim
      nvim-oxi
    ]
  );
}

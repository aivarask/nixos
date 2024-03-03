{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-go
    nvim-dap-python
    nvim-dap-vscode-js
  ];
}

{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-fzf-native-nvim
    telescope-dap-nvim
    telescope-symbols-nvim
    trouble-nvim
    todo-comments-nvim
  ];
}

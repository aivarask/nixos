{ pkgs, ... }:
let
  commonPlugins = with pkgs.vimPlugins; [
    # ack-vim # 2018
    vim-projectionist
    vim-log-highlighting
    vim-jsdoc
    telescope-fzf-native-nvim
    # vim-obsession
    vim-devicons
    vim-abolish
    vim-dispatch

    vim-cool
    vim-sensible
    vim-lastplace
    bclose-vim
    vim-commentary
    # auto-pairs
    vim-fugitive
    fugitive-gitlab-vim
    vim-surround
    vim-floaterm
    fzf-vim

    lf-vim
    vim-gruvbox8
    gruvbox-material

    vim-colors-solarized
    vim-highlightedyank

    switch-vim
    vim-jsx-pretty
    vim-matchup
  ];
  nvimOnlyPlugins = with pkgs.vimPlugins; [
    # Session
    persistence-nvim
    neovim-session-manager
    project-nvim
    telescope-project-nvim
    which-key-nvim

    # https://github.com/itchyny/vim-cursorword/
    vim-cursorword
    # https://github.com/lfv89/vim-interestingwords
    vim-interestingwords
    indent-blankline-nvim

    # LSP:
    refactoring-nvim
    lsp_signature-nvim
    lsp-overloads-nvim
    nvim-lsp-file-operations
    nvim-lspconfig
    # null-ls-nvim
    none-ls-nvim
    symbols-outline-nvim
    SchemaStore-nvim
    hover-nvim
    goto-preview
    # TEST
    neotest
    neotest-plenary
    # COMPLETION:
    # https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    cmp-nvim-lsp-signature-help
    nvim-cmp
    cmp-cmdline
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-emoji
    cmp-zsh
    cmp-git
    # cmp-treesitter
    lspkind-nvim
    nvim-autopairs
    cmp_luasnip # https://github.com/saadparwaiz1/cmp_luasnip
    luasnip # https://github.com/L3MON4D3/LuaSnip
    friendly-snippets # https://github.com/rafamadriz/friendly-snippets
    # TREE_SITTER:
    nvim-treesitter.withAllGrammars
    nvim-ts-context-commentstring
    nvim-treesitter-textobjects
    nvim-ts-autotag
    nvim-treesitter-endwise

    # OTHER
    lazygit-nvim
    pretty-fold
    fold-preview
    template-string-nvim

    # UI/UX:
    # auto-session
    dressing-nvim
    lualine-nvim
    lualine-lsp-progress
    nvim-web-devicons
    neoscroll-nvim
    nvim-tree-lua
    nvim-colorizer-lua
    toggleterm-nvim

    # DEBUG:
    vimspector
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    osv
    nvim-dap-vscode-js
    nvim-dap-python
    flatten-nvim
    nvim-dap-go
    # --

    # UI
    glow-nvim
    telescope-nvim
    telescope-dap-nvim
    telescope-fzy-native-nvim
    # telescope-cheat-nvim
    telescope-symbols-nvim
    trouble-nvim # https://github.com/folke/trouble.nvim
    todo-comments-nvim # https://github.com/folke/todo-comments.nvim
  ];
in
{
  # programs.vim = {
  #   enable = true;
  #   plugins = vimOnlyPlugins ++ commonPlugins;
  #   extraConfig = ''
  #     let &runtimepath.=',/etc/nixos/vim'
  #     source /etc/nixos/vim/vimrc.vim
  #   '';
  # };
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos/vim'
        lua << EOF
        dofile("/etc/nixos/vim/init.lua")
        EOF
      ''
    ];
    package = pkgs.neovim-nightly;
    plugins = nvimOnlyPlugins ++ commonPlugins;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
}

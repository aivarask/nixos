{pkgs, ...}: let
  vimOnlyPlugins = with pkgs.vimPlugins; [
    # LANG:
    context_filetype-vim
    vim-nix
    vim-toml
    vim-yaml
    vim-json
  ];
  commonPlugins = with pkgs.vimPlugins; [
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
    vim-expand-region
    vim-gitgutter
    # vim-gutentags
    vim-floaterm
    fzf-vim
    refactoring-nvim

    lf-vim
    vim-gruvbox8
    gruvbox-material
    vim-monokai-tasty
    vim-monokai
    vim-monokai-pro
    monokai-pro-nvim

    # nord-nvim
    # onedark-vim
    vim-colors-solarized
    # vim-monokai
    # tokyonight-nvim
    # nightfox-nvim
    vim-highlightedyank

    nginx-vim
    sslsecure-vim

    switch-vim
    vim-jsx-pretty
    vim-prisma
    # direnv-vim
    vim-matchup
    vim-auto-save
    scss-syntax-vim
  ];
  nvimOnlyPlugins = with pkgs.vimPlugins; [
    ChatGPT-nvim
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
    lsp_signature-nvim
    lsp-overloads-nvim
    nvim-lsp-file-operations
    nvim-lspconfig
    # null-ls-nvim
    none-ls-nvim
    symbols-outline-nvim
    SchemaStore-nvim
    diaglist-nvim
    hover-nvim
    goto-preview
    # TEST
    vim-test
    neotest
    neotest-vim-test
    neotest-vitest
    neotest-plenary
    neotest-playwright
    neotest-jest
    neotest-go
    neotest-phpunit
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
    # TODO: initialize and config https://github.com/stevearc/dressing.nvim
    dressing-nvim
    lualine-nvim
    lualine-lsp-progress
    # tabline-nvim archived
    nvim-web-devicons
    neoscroll-nvim
    nvim-tree-lua
    nvim-colorizer-lua
    gitsigns-nvim
    toggleterm-nvim
    # plenary-nvim

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
in {
  programs.vim = {
    enable = true;
    plugins = vimOnlyPlugins ++ commonPlugins;
    extraConfig = ''
      source /etc/nixos/vim/vimrc.vim
    '';
  };
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      # set rtp+=${pkgs}
      ''
        lua << EOF
        dofile("/etc/nixos/vim/init.lua")
        EOF
      ''
    ];
    # extraPackages = with pkgs; [ tree-sitter ];
    # package = pkgs.neovim;
    package = pkgs.neovim-nightly;
    plugins = nvimOnlyPlugins ++ commonPlugins;
    viAlias = false;
    vimAlias = false;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}

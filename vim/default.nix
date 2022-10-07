{ config, pkgs, lib, ... }:
let
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        inherit ref;
      };
    };
  plugin = pluginGit "HEAD";
  vimPlugins = with pkgs.vimPlugins; [
    vim-devicons
    vim-hexokinase

    context_filetype-vim
    vim-cool
    vim-sensible
    vim-lastplace
    bclose-vim
    vim-commentary
    # auto-pairs
    vim-fugitive
    fugitive-gitlab-vim
    vim-autoformat
    vim-surround
    vim-expand-region
    vim-gitgutter
    # vim-gutentags
    vim-floaterm
    fzf-vim

    lf-vim
    nerdtree
    vim-gruvbox8
    gruvbox-material
    nord-nvim
    onedark-vim
    vim-colors-solarized
    vim-monokai
    tokyonight-nvim
    nightfox-nvim
    # vim-airline
    # vim-airline-themes
    vim-highlightedyank

    # lightline-vim
    # lightline-bufferline
    # nvim-lightline-lsp
    # lightline-gruvbox-vim

    neoformat
    vim-pug

    vim-nix
    nim-vim
    vim-toml
    vim-yaml
    vim-json
    switch-vim
    vim-jsx-pretty
    lspkind-nvim
    vim-test
    vim-prisma
    # direnv-vim
    vim-matchup
    vim-auto-save
  ];
  nvimPlugins = with pkgs.vimPlugins; [
    # TOOLS:

    project-nvim
    SchemaStore-nvim

    lualine-nvim
    lualine-lsp-progress
    tabline-nvim

    toggleterm-nvim
    todo-comments-nvim
    nvim-autopairs
    nvim-web-devicons
    plenary-nvim
    lazygit-nvim
    # UI:
    # bufferline-nvim
    neoscroll-nvim
    nvim-tree-lua
    nvim-colorizer-lua
    gitsigns-nvim
    # LSP:
    nvim-lspconfig
    nvim-lsp-ts-utils # NEW:
    # nvim-treesitter-textsubjects
    null-ls-nvim
    symbols-outline-nvim
    # COMPLETION:
    # https://github.com/hrsh7th
    # ./lua/compl.lua
    lua-dev-nvim
    cmp-nvim-lua
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-emoji
    cmp-treesitter
    nvim-cmp
    # VSNIP:
    cmp-vsnip
    vim-vsnip
    vim-vsnip-integ
    friendly-snippets # https://github.com/rafamadriz/friendly-snippets
    # LUSNIP:
    luasnip # https://github.com/L3MON4D3/LuaSnip
    cmp_luasnip # https://github.com/saadparwaiz1/cmp_luasnip
    # DEBUG:
    # ./lua/dmap.lua
    vimspector
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text

    telescope-nvim
    telescope-dap-nvim
    telescope-fzy-native-nvim
    # telescope-cheat-nvim
    telescope-symbols-nvim

    # TREE_SITTER:
    {
      plugin = nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars);
    }
    nvim-ts-context-commentstring
    nvim-ts-rainbow
    nvim-treesitter-textobjects
    nvim-ts-autotag
  ];
in
{
  # xdg.configFile."nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";

  home.file.".vim/coc-settings.json".source = ./coc-settings.json;
  programs.vim = {
    enable = true;
    plugins = vimPlugins ++ import ./cocPlugins.nix pkgs;
    extraConfig = ''
      source /etc/nixos/vim/vimrc.vim
    '';
  };
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        lua << EOF
        dofile("/etc/nixos/vim/init.lua")
        EOF
      ''
    ];
    extraPackages = with pkgs; [ tree-sitter ];
    package = pkgs.neovim-nightly;
    plugins = vimPlugins ++ nvimPlugins;
    viAlias = true;
    vimAlias = false;
    vimdiffAlias = true;
    withNodeJs = true;
    # withPython2 = true;
    withPython3 = true;
    withRuby = true;
  };
}


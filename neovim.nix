{ pkgs, ... }:
let
  vimPlugins = with pkgs.vimPlugins; [
    vim-log-highlighting # https://github.com/MTDL9/vim-log-highlighting
    {
      plugin = vim-interestingwords; # https://github.com/lfv89/vim-interestingwords
      config = "let g:interestingWordsDefaultMappings = 1";
    }
    vim-highlightedyank
    vim-cursorword
    vim-devicons
    vim-cool
    vim-sensible
    vim-lastplace
    vim-commentary
    {
      plugin = bclose-vim;
      config = ''
        let g:bclose_no_plugin_maps=1
        nnoremap <silent> <M-q> :Bclose<CR>
        nnoremap <M-Q> :Bclose!<CR>
      '';
    }
    {
      plugin = vim-abolish;
      config = ''
        nmap <leader><leader>s :Subvert/<C-r><C-w>//g<Left><Left>
        nmap <leader><leader>S :%Subvert/<C-r><C-w>//g<Left><Left>
      '';
    }
    {
      plugin = auto-pairs;
      config = ''
        let g:AutoPairsFlyMode = 1
        let g:AutoPairsShortcutBackInsert = '<C-b>'
      '';
    }
    {
      plugin = vim-floaterm;
      config = ''
        let g:floaterm_autoclose = 2
        let g:floaterm_height = 0.7
        let g:floaterm_width = 0.8
        let g:floaterm_wintype = 'float'
        autocmd VimResized * FloatermUpdate
        if !has('nvim')
          nnoremap <F12> :FloatermToggle<CR>
          tnoremap <F12> <C-W>:FloatermToggle<CR>
        endif
      '';
    }
    {
      plugin = lf-vim;
      config = "let g:lf_map_keys = 0";
    }
    {
      plugin = gruvbox-material;
      config = ''
        if has('termguicolors')
          set termguicolors
        endif
        set background=dark
        let g:gruvbox_material_background = 'medium'
        let g:gruvbox_material_foreground = 'mix'
        colorscheme gruvbox-material
      '';
    }
    {
      plugin = switch-vim; # _switch.vim
      config = ''
        let g:switch_mapping = ""
        nnoremap <silent> <Plug>(SwitchInLine) :<C-U>call SwitchLine(v:count1)<CR>
        nmap <M-s> <Plug>(SwitchInLine)
        imap <M-s> <C-O><M-s>
      '';
    }
    fzf-vim # _fzf.vim
    vim-surround # _surround.vim
    vim-matchup # _treesitter.lua
    # vimspector
  ];
  nvimPlugins = with pkgs.vimPlugins; [
    # auto-session
    # https://github.com/Shatur/neovim-session-manager
    neovim-session-manager # plugin/_session.lua 
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
        require('which-key').setup({})
        wkr = require('which-key').register
      '';
    }
    {
      plugin = indent-blankline-nvim;
      config = "require('ibl').setup({})";
      type = "lua";
    }
    lazygit-nvim
    lualine-nvim # plugin/_lualine.lua
    lualine-lsp-progress
    nvim-tree-lua # plugin/_nvim-tree.lua
    toggleterm-nvim # plugin/_terminal.lua
  ];
  codelens = with pkgs.vimPlugins; [
    # plugin/__codelens.lua
    fold-preview
    goto-preview
    hover-nvim
    pretty-fold
  ];
  completion = with pkgs.vimPlugins; [
    # plugin/__completion.lua
    nvim-autopairs # _autopairs.lua
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    cmp-cmdline
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-emoji
    cmp-zsh
    cmp-git
    cmp_luasnip # https://github.com/saadparwaiz1/cmp_luasnip
    luasnip # https://github.com/L3MON4D3/LuaSnip
    friendly-snippets # https://github.com/rafamadriz/friendly-snippets
    # cmp-treesitter
  ];
  dap = with pkgs.vimPlugins; [
    # plugin/__dap.lua
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    osv
    nvim-dap-vscode-js
    nvim-dap-python
    nvim-dap-go
  ];
  lsp = with pkgs.vimPlugins; [
    # plugin/__lsp.lua
    nvim-lspconfig
    refactoring-nvim
    lsp_signature-nvim
    lsp-overloads-nvim
    { plugin = nvim-lsp-file-operations; type = "lua"; config = "require('lsp-file-operations').setup({ debug = false })"; }
    none-ls-nvim
    SchemaStore-nvim
  ];
  misc = with pkgs.vimPlugins; [
    # plugin/__misc.lua
    symbols-outline-nvim
    flatten-nvim
    glow-nvim
    { plugin = dressing-nvim; type = "lua"; config = "require('dressing').setup({})"; }
    { plugin = neoscroll-nvim; type = "lua"; config = "require('neoscroll').setup({})"; }
    { plugin = nvim-colorizer-lua; type = "lua"; config = "require('colorizer').setup({})"; }
    { plugin = nvim-web-devicons; type = "lua"; config = "require('nvim-web-devicons').setup({})"; }
  ];
  neotestPlugins = with pkgs.vimPlugins; [
    neotest # plugin/__neotest.lua
    neotest-plenary
  ];
  telescope = with pkgs.vimPlugins; [
    telescope-nvim # plugin/__telescope.lua
    telescope-fzf-native-nvim
    telescope-dap-nvim
    telescope-symbols-nvim
    trouble-nvim
    todo-comments-nvim
  ];
  treesitter = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars # plugin/__treesitter.lua
    { plugin = nvim-ts-context-commentstring; type = "lua"; config = "require('ts_context_commentstring').setup({})"; }
    nvim-treesitter-textobjects
    nvim-ts-autotag
    nvim-treesitter-endwise
  ];
in
{
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos'
        lua << EOF
        dofile("/etc/nixos/init.lua")
        EOF
      ''
    ];
    package = pkgs.neovim-nightly;
    plugins = vimPlugins
      ++ nvimPlugins
      ++ codelens
      ++ completion
      ++ dap
      ++ lsp
      ++ misc
      ++ neotestPlugins
      ++ telescope
      ++ treesitter;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
  programs.vim = {
    enable = true;
    # plugins = commonPlugins;
    extraConfig = ''
      let &runtimepath.=',/etc/nixos'
      source /etc/nixos/vimrc.vim
    '';
  };
}

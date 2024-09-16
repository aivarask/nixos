{ pkgs, ... }:
let
  codelens = with pkgs.vimPlugins; [
    # fold-preview-nvim
    goto-preview
    hover-nvim
    # pretty-fold-nvim
  ];
  completion = with pkgs.vimPlugins; [
    nvim-autopairs
    cmp_luasnip
    luasnip
    friendly-snippets
    nvim-cmp
    cmp-nvim-lsp
    cmp-emoji
    cmp-path
    cmp-buffer
    cmp-cmdline
    cmp-zsh
    cmp-git
    cmp-dap
  ];
  dap = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-dap-go
    nvim-dap-python
    # rustaceanvim
  ];
  lsp = with pkgs.vimPlugins; [
    conform-nvim
    SchemaStore-nvim
    nvim-lspconfig
    none-ls-nvim
    refactoring-nvim
    lsp_signature-nvim
    # lsp-overloads-nvim
  ];
  misc = with pkgs.vimPlugins; [
    outline-nvim
    flatten-nvim
    glow-nvim
    neoscroll-nvim
    dressing-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    image-nvim
  ];
  telescope = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-fzf-native-nvim
    telescope-dap-nvim
    telescope-symbols-nvim
    trouble-nvim
    todo-comments-nvim
    telescope-manix
  ];
  testing = with pkgs.vimPlugins; [
    # vim-test
    neotest
    neotest-bash
    neotest-go
    neotest-jest
    neotest-phpunit
    neotest-pest
    neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
    neotest-vitest
  ];
  treesitter = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-endwise
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    nvim-treesitter-textobjects
    nvim-treesitter-textsubjects
  ];
  next = with pkgs.vimPlugins; [
    nui-nvim
    nvim-notify
    plenary-nvim
    pkgs.vimPlugins.fidget-nvim
  ];
  disabled =
    [
    ];

  common = with pkgs.vimPlugins; [
    bclose-vim
    fzf-vim
    gruvbox-material
    lf-vim
    switch-vim
    vim-abolish
    vim-commentary
    vim-cool
    vim-cursorword
    vim-devicons
    vim-floaterm
    vim-highlightedyank
    vim-lastplace
    vim-matchup
    direnv-vim
  ];
in
{
  home.packages = [ pkgs.manix ];

  programs.neovim.extraLuaPackages = ps: [
    ps.magick
  ];
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      "let &runtimepath.=',/etc/nixos'"
    ];
    extraLuaConfig = builtins.concatStringsSep "\n" [

    ];
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
  programs.neovim.plugins =
    codelens
    ++ completion
    ++ dap
    ++ lsp
    ++ misc
    ++ testing
    ++ telescope
    ++ treesitter
    ++ next
    ++ (with pkgs.vimPlugins; [
      auto-session
      which-key-nvim
      nvim-surround
      indent-blankline-nvim
      lazygit-nvim
      neogit
      gitsigns-nvim
      lualine-nvim
      nvim-tree-lua
      neorepl-nvim
      iron-nvim
      toggleterm-nvim
      {
        plugin = sqlite-lua;
        config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
      }
    ])
    ++ common
    ++ (with pkgs.vimPlugins; [
      vim-sensible
    ]);
  programs.vim = {
    enable = true;
    plugins =
      common
      ++ (with pkgs.vimPlugins; [
        # vim-repeat vim-sensible vim-matchit
        vim-surround
        auto-pairs
      ]);
    settings = { };
    extraConfig = ''
      let &runtimepath.=',/etc/nixos'
    '';
  };
}

{ pkgs, ... }:
let
  codelens = with pkgs.vimPlugins;[
    fold-preview-nvim
    goto-preview
    hover-nvim
    pretty-fold-nvim
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
  lsp = with pkgs.vimPlugins; [
    SchemaStore-nvim
    nvim-lspconfig
    none-ls-nvim
    nvim-lsp-file-operations
    refactoring-nvim
    lsp_signature-nvim
    lsp-overloads-nvim
  ];
  misc = with pkgs.vimPlugins; [
    aerial-nvim
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
  ];
  treesitter =
    with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-endwise
      nvim-ts-autotag
      nvim-treesitter-context
      nvim-ts-context-commentstring
      nvim-treesitter-textobjects
      nvim-treesitter-textsubjects
    ];
  next =
    with pkgs.vimPlugins; [
      nui-nvim
    ];
in
{
  programs.neovim.extraLuaPackages = ps: [
    ps.magick #NOTE: needed by image-nvim
  ];
  programs.neovim.plugins = codelens ++ completion ++ lsp ++ misc ++ telescope ++ treesitter ++ next ++ (with pkgs.vimPlugins; [
    sxhkd-vim
    persistent-breakpoints
    auto-session
    which-key-nvim
    nvim-surround
    indent-blankline-nvim
    lazygit-nvim
    neogit
    gitsigns-nvim
    lualine-nvim
    lualine-lsp-progress
    nvim-tree-lua
    neorepl-nvim
    iron-nvim
    toggleterm-nvim
    {
      plugin = sqlite-lua;
      config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
    }
  ]);
}

{
  pkgs,
  lib,
  config,
  osConfig,
  inputs,
  ...
}:
let
  COMMON = with pkgs.vimPlugins; [
    gruvbox-material
    vim-auto-save
    bclose-vim
    fzf-vim
    gruvbox-material
    switch-vim
    vim-abolish
    vim-cool
    vim-devicons
    vim-highlightedyank
    vim-lastplace
    direnv-vim
    tabular
  ];
in
{
  xdg.configFile."vim".source = osConfig.symlink "/etc/nixos/lua";
  programs.vim.enable = true;
  programs.vim.extraConfig = "source $XDG_CONFIG_HOME/vim/vimrc";
  programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (
    lib.mkMerge [
      COMMON
      (with pkgs.vimPlugins; [
        vim-airline
        vim-which-key
        auto-pairs
        nerdtree
        vim-nerdtree-syntax-highlight
        vim-indentwise
        vim-commentary
        vim-matchup
      ])
    ]
  );
  programs.neovim.enable = true;
  programs.neovim.initLua =
    let
      nvimEarlyInit = lib.mkOrder 500 ''
        vim.opt.rtp:prepend('/etc/nixos')
        require('nixos')
      '';
      # nvimLateInit = lib.mkAfter "vim.opt.signcolumn = 'auto:1-3'";
    in
    lib.mkMerge [
      nvimEarlyInit
      # nvimLateInit
    ];
  programs.neovim.package =
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  programs.neovim.extraLuaPackages =
    ps: with ps; [
      plenary-nvim
      penlight
      cjson
      http
      cqueues
      luaossl
      basexx
      lpeg
      lpeg_patterns
      binaryheap
      luafilesystem
      fifo
      lua-zlib
      compat53
    ];
  home.sessionVariables.SQLITE_CLIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
  programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
    lib.mkMerge [
      COMMON
      (with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (ps: [
          ps.nix
        ]))
        nvim-nio
        auto-session
        which-key-nvim
        lazygit-nvim
        lualine-nvim
        nvim-tree-lua
        toggleterm-nvim
        sqlite-lua
      ])
      (with pkgs.vimPlugins; [
        nvim-notify
        fidget-nvim
        luvit-meta
        nvim-lsp-file-operations
        smart-semicolon
      ])
      # misc
      (lib.mkIf true (
        with pkgs.vimPlugins;
        [
          SchemaStore-nvim
          outline-nvim
          flatten-nvim
          nvim-colorizer-lua
          nvim-web-devicons
          mini-icons
          image-nvim
          telescope-nvim
        ]
      ))

    ]
  );
}

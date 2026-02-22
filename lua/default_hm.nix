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
    pkgs.vimPlugins.gruvbox-material
    ack-vim
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
  xdg.configFile."vim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lua";
  programs.vim.enable = true;
  programs.vim.extraConfig = ''source $XDG_CONFIG_HOME/vim/vimrc'';
  programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (
    lib.mkMerge [
      COMMON
      (with pkgs.vimPlugins; [
        vim-airline
        vim-which-key
        auto-pairs
        nerdtree
        #
        vim-indentwise
        vim-commentary
        vim-matchup
      ])
    ]
  );
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lua";
  programs.neovim.enable = true;
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
      fifo # dep in neovim only
      lua-zlib
      compat53
      # lua-psl
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
        # new
        nvim-notify
        fidget-nvim
        luvit-meta
        # overlays
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
          telescope-fzf-native-nvim
        ]
      ))

    ]
  );
}

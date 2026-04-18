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
    vim-scriptease
  ];
in
{
  home.packages = with pkgs; [
    # ctags
    universal-ctags
    geekbench
  ];
  xdg.configFile."vim".source = osConfig.symlink "/etc/nixos/lua";
  programs.vim.enable = true;
  programs.vim.extraConfig = "source $XDG_CONFIG_HOME/vim/vimrc";
  programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (
    lib.mkMerge [
      COMMON
      (with pkgs.vimPlugins; [
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
  home.sessionVariables.SQLITE_CLIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
  programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
    lib.mkMerge [
      COMMON
      (with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (ps: [ ps.nix ]))
        nvim-nio
        which-key-nvim
        SchemaStore-nvim
        flatten-nvim
        nvim-colorizer-lua
        nvim-web-devicons
        mini-icons
        image-nvim
        sqlite-lua
        kitty-scrollback-nvim
        nvim-notify
        fidget-nvim
        luvit-meta
      ])

    ]
  );
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

}

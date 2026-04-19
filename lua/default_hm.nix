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
    vim-obsession
    vim-gutentags
    ctrlp-vim
  ];
in
  {

    home.packages = with pkgs; [
      clang
      clang-tools
      bear
      cmake
      libsixel
      pkg-config
      universal-ctags
      cscope
      gdb
      (pkgs.netsurf-browser.override { uilib = "gtk3"; }) # framebuffer
      pkgs.xterm
      lsix
      viu
    ];

  # vim {{{
    xdg.configFile."vim".source = osConfig.symlink "/etc/nixos/lua";
    programs.vim.enable = true;
    programs.vim.extraConfig = "source $XDG_CONFIG_HOME/vim/shared.vim";
    programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (lib.mkMerge [ COMMON ]);
# }}}

  # nvim {{{
    xdg.configFile."nvim/after".source = osConfig.symlink "/etc/nixos/lua/after";
    xdg.configFile."nvim/autoload".source = osConfig.symlink "/etc/nixos/lua/autoload";
    xdg.configFile."nvim/plugin".source = osConfig.symlink "/etc/nixos/lua/plugin";
    xdg.configFile."nvim/shared.vim".source = osConfig.symlink "/etc/nixos/lua/shared.vim";
    xdg.configFile."nvim/setup.lua".source = osConfig.symlink "/etc/nixos/lua/setup.lua";
    programs.neovim.enable = true;
    programs.neovim.initLua =
      let
        nvimEarlyInit = lib.mkOrder 500 ''
        vim.opt.rtp:prepend('/etc/nixos')
        vim.cmd.source('~/.config/nvim/shared.vim')
        require('setup')
        '';
      in
      lib.mkMerge [
        nvimEarlyInit
    ];
    home.sessionVariables.SQLITE_CLIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
    programs.neovim.package =
      inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
        lib.mkMerge [
          COMMON
          (with pkgs.vimPlugins; [
            (nvim-treesitter.withPlugins (ps: [ ps.nix ]))
            nvim-nio
            SchemaStore-nvim
            flatten-nvim
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
    # }}}

  }

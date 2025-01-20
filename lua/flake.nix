{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };
  outputs = _: {
    nixosModules = {
      vim.home =
        { pkgs, ... }:
        {
          programs.vim = {
            enable = true;
            plugins =
              # common
              [ ]
              ++ (with pkgs.vimPlugins; [
                # vim-repeat vim-sensible vim-matchit
                vim-airline
                vim-which-key
                vim-surround
                auto-pairs
                nerdtree
              ]);
            settings = { };
            extraConfig = ''
              let &packpath.=',/etc/nixos'
              let &runtimepath.=',/etc/nixos'
              runtime! lua/cfg/**/*.vim
              runtime! lua/_*.vim
            '';
          };

        };

    };
  };
}

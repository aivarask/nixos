{
  inputs.nixpkgs.url = "nixpkgs";
  outputs = _: {
    nixosModules = {
      default =
        { pkgs, ... }:
        let
          myLua = pkgs.luajit.withPackages (
            ps: with ps; [
              # https://github.com/rest-nvim/rest.nvim
              luv
              cjson
              luasocket # https://github.com/lunarmodules/luasocket
              magick
              cqueues
              http # https://github.com/daurnimator/lua-http
              inspect
              lpeglabel
              cjson
              luasec
              luasql-sqlite3
              penlight
              # nlua # nvim as lua interpreter
            ]
          );
        in
        {
          environment.etc."luajit".source = myLua;
          environment.etc."lua-language-server".source = pkgs.lua-language-server;
          environment.systemPackages =
            with pkgs;
            [
              neovim-remote
              awesome
              stylua
              lua-language-server
              myLua
            ]
            ++ [
              # pkgs.luajitPackages.inspect
            ];

        };

    };
  };
}

{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
  };
  outputs =
    { nixpkgs, ... }@inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      # https://github.com/NixOS/nix/blob/master/src/nix/flake-check.md
      # devShells."x86_64-linux".default = pkgs.mkShell {};
      # checks."x86_64-linux".zoo = import ./test.nix nixpkgs.legacyPackages."x86_64-linux";

      checks."x86_64-linux".zsh = pkgs.testers.runNixOSTest {
        name = "zsh";
        nodes.machine =
          { pkgs, ... }:
          {
            environment.systemPackages = [ pkgs.zsh ];
          };
        testScript = builtins.readFile ./flake.test.py;
      };
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.profiles = [
            "${./.}"
            "${pkgs.zsh-completions}"
            "${pkgs.zsh-abbr}"
          ];
        };
      hmModules.default =
        {
          pkgs,
          lib,
          config,
          ...
        }:
        {
          home.packages = with pkgs; [
            zed-editor
            nodePackages.bash-language-server
            shellcheck
            shfmt
            dotenv-linter
            shellharden
          ];
          programs.bash.enable = true;
          programs.zsh = {
            enable = true;
            autocd = true;
            syntaxHighlighting.enable = true;
            autosuggestion.enable = true;
            dotDir = ".config/zsh";
            history = {
              size = 10000;
              extended = true;
            };
            profileExtra = '''';
            initExtraBeforeCompInit = ''
              # programs.zsh.initExtraBeforeCompinit
            '';
            completionInit = ''
              # programs.zsh.completionInit
            '';
            initExtra = ''
              # programs.zsh.initExtra
              source /etc/nixos/zsh/zshrc
            '';
            plugins = [
              {
                # https://github.com/olets/zsh-abbr
                # https://zsh-abbr.olets.dev
                name = "zsh-abbr";
                src = pkgs.zsh-abbr;
                file = "share/zsh/zsh-abbr/zsh-abbr.plugin.zsh";
              }
              {
                # https://github.com/olets/zsh-autosuggestions-abbreviations-strategy
                name = "zsh-autosuggestions-abbreviations-strategy";
                src = pkgs.zsh-autosuggestions-abbreviations-strategy;
                file = "share/zsh/site-functions/zsh-autosuggestions-abbreviations-strategy.plugin.zsh";
              }
              # {
              #   # https://github.com/jeffreytse/zsh-vi-mode
              #   name = "vi-mode";
              #   src = pkgs.zsh-vi-mode;
              #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
              # }
              # {
              #   # https://github.com/kutsan/zsh-system-clipboard
              #   # https://github.com/kutsan/zsh-system-clipboard#options
              #   name = "system-clipboard";
              #   src = pkgs.zsh-system-clipboard;
              #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
              # }
            ];
          };
          programs.firefox.profiles.root.bookmarks = lib.mkIf config.programs.firefox.enable [
            # ~/.mozilla/firefox/root/user.js
            {
              name = "zsh-toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "zsh"; # folder
                  bookmarks = [
                    {
                      name = "zsh-abbr";
                      url = "${pkgs.zsh-abbr.meta.homepage}";
                      # tags = [ "zsh-abbr" ];
                      # keyword = "";
                    }
                    {
                      name = "zsh-autosuggestions-abbreviations-strategy";
                      url = "${pkgs.zsh-autosuggestions-abbreviations-strategy.meta.homepage}";
                    }
                  ];
                }
              ];
            }
          ];
        };
    };
}

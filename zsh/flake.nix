{
  inputs.nixpkgs.url = "nixpkgs";
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
    in
    {
      nixosModules = {
        env.sys =
          { ... }:
          {
            environment.profiles = [
              "${./.}"
              # "${pkgs.zsh-completions}"
            ];

            # /etc/profile
            programs.bash.shellInit = ''
              # OS programs.bash.shellInit
            '';
            environment.shellInit = ''
              # OS environment.shellInit
              source /etc/nixos/profile
            '';

            # /etc/set-environment
            environment.extraInit = ''
              # OS environment.extraInit
            '';

            # /etc/bashrc
            programs.bash.interactiveShellInit = ''
              # OS programs.bash.interactiveShellInit
            '';
            environment.interactiveShellInit = ''
              # OS environment.interactiveShellInit
            '';

            # /etc/zshenv
            # /etc/zshrc
            programs.zsh.enable = true;
            programs.zsh.shellInit = ''
              # OS programs.zsh.shellInit
            '';
          };
        env.hm =
          { ... }:
          {
            # /etc/profiles/per-user/root/etc/profile.d/hm-session-vars.sh
            # https://mynixos.com/home-manager/options/xsession
            xsession.enable = true;
            xsession.profileExtra = ''
              # HM xsession.profileExtra
            '';
            xsession.initExtra = ''
              # HM xsession.initExtra
            '';
            # https://mynixos.com/home-manager/options/programs.bash
            programs.bash.enable = true;
            programs.bash.profileExtra = ''
              # HM programs.bash.profileExtra
            '';
            programs.bash.initExtra = ''
              # HM programs.bash.initExtra
            '';
            programs.zsh.enable = true;
            programs.zsh.profileExtra = ''
              # HM programs.zsh.profileExtra
            '';
            programs.zsh.initExtraBeforeCompInit = ''
              # HM programs.zsh.initExtraBeforeCompinit
            '';
            programs.zsh.completionInit = ''
              # HM programs.zsh.completionInit
            '';
            programs.zsh.initExtra = ''
              # programs.zsh.initExtra
              source /etc/nixos/zsh/zshrc
            '';
          };

        hm =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              zed-editor
              bash-language-server
              shellcheck
              shfmt
              dotenv-linter
              shellharden
            ];
            programs.zsh = {
              autocd = true;
              syntaxHighlighting.enable = true;
              autosuggestion.enable = true;
              dotDir = ".config/zsh";
              history = {
                size = 10000;
                extended = true;
              };
            };

          };
        ff.bookmarks =
          { lib, config, ... }:
          {
            programs.firefox.profiles.root.bookmarks = lib.mkIf config.programs.firefox.enable {
              force = true;
              settings = [
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
        plugins =
          { ... }:
          {
            programs.zsh.plugins = [
              # {
              #   # https://github.com/olets/zsh-abbr
              #   # https://zsh-abbr.olets.dev
              #   name = "zsh-abbr";
              #   src = pkgs.zsh-abbr;
              #   file = "share/zsh/zsh-abbr/zsh-abbr.plugin.zsh";
              # }
              # {
              #   # https://github.com/olets/zsh-autosuggestions-abbreviations-strategy
              #   name = "zsh-autosuggestions-abbreviations-strategy";
              #   src = pkgs.zsh-autosuggestions-abbreviations-strategy;
              #   file = "share/zsh/site-functions/zsh-autosuggestions-abbreviations-strategy.plugin.zsh";
              # }
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
      };
      checks."${system}".zsh = pkgs.testers.runNixOSTest {
        # https://github.com/NixOS/nix/blob/master/src/nix/flake-check.md
        name = "zsh";
        nodes.machine =
          { pkgs, ... }:
          {
            environment.systemPackages = [ pkgs.zsh ];
          };
        testScript = ''
          machine.start()
          machine.wait_for_unit("default.target")
          machine.succeed("which zsh")
        '';
      };
    };
}

{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    nps.url = "github:OleMussmann/nps";
    nps.inputs.nixpkgs.follows = "nixpkgs";
    templates.url = "github:NixOS/templates";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    #
    LS_COLORS.url = "./LS_COLORS";
    audio.url = "./audio";
    firefox.url = "./firefox";
    fzf.url = "./fzf";
    git.url = "./_git";
    go.url = "./go";
    lf.url = "./lf";
    lib.url = "./lib";
    lua.url = "./lua";
    manix.url = "./manix";
    matrix.url = "./matrix";
    pistol.url = "./pistol";
    rust.url = "./rust";
    suckless.url = "./suckless";
    tmux.url = "./tmux";
    vim.url = "./vim";
    wayland.url = "./wayland";
    zsh.url = "./zsh";
    #
    # aldale.url = "./aldale";
    aiva.url = "./aiva";
  };
  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.nur.overlays.default
          (final: prev: {
            nps = inputs.nps.packages.${prev.system}.default;
          })
          # inputs.firefox.overlays.default
        ];
      };
      commonModules = with inputs; [
        {
          environment.systemPackages = [
            pkgs.nps # https://github.com/OleMussmann/nps
          ];
          systemd.timers."refresh-nps-cache" = {
            wantedBy = [ "timers.target" ];
            timerConfig = {
              OnCalendar = "5m"; # daily
              Persistent = true;
              Unit = "refresh-nps-cache.service";
            };
          };

          systemd.services."refresh-nps-cache" = {
            # Make sure `nix` and `nix-env` are findable by systemd.services.
            path = [ "/run/current-system/sw/" ];
            serviceConfig = {
              Type = "oneshot";
              User = "REPLACE_ME"; # ⚠️ replace with your "username" or "${user}", if it's defined
            };
            script = ''
              set -eu
              echo "Start refreshing nps cache..."
              ${pkgs.nps}/bin/nps -dddd -e -r
              echo "... finished nps cache with exit code $?."
            '';
          };
        }
        {
          environment.systemPackages = [
            pkgs.git
          ];
        }
        inputs.LS_COLORS.nixosModules.default
        inputs.audio.nixosModules.mpd
        inputs.audio.nixosModules.pipewire
        inputs.audio.nixosModules.production
        inputs.firefox.nixosModules.default
        inputs.fzf.nixosModules.default
        inputs.git.nixosModules.default
        inputs.go.nixosModules.default
        inputs.lf.nixosModules.default
        inputs.lib.nixosModules.default
        inputs.lua.nixosModules.default
        inputs.manix.nixosModules.default
        inputs.matrix.nixosModules.default
        inputs.pistol.nixosModules.default
        inputs.rust.nixosModules.default
        inputs.suckless.nixosModules.default
        inputs.vim.nixosModules.default
        inputs.vim.nixosModules.plugins.default
        inputs.zsh.nixosModules.env.sys
        # inputs.aldale.nixosModules.default
        # inputs.aiva.nixosModules.default
        # inputs.wayland.nixosModules.default
        # inputs.firefox.nixosModules.pass.default
        ./ai
        ./dialog
        {
          imports =
            with inputs.lib.packages."${system}".lib;
            (
              [
                ./lnav
                ./systemd/remote-touchpad.nix
                ./systemd/music.nix
                ./systemd/video.nix
                ./virt/virtualbox.nix
                ./wallpaper
              ]
              ++ i ./config
              ++ i ./network
              ++ i ./programs
              ++ idash ./services
            );
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.root = {
              home.stateVersion = "23.05";
              home.username = "root";
              home.homeDirectory = "/root";
              home.enableNixpkgsReleaseCheck = false;
              manual.json.enable = true;
              programs.man.generateCaches = true;
              colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
              services.mpris-proxy.enable = true; # https://specifications.freedesktop.org/mpris-spec/latest/
              # services.blueman-applet.enable = true;
              imports =
                with inputs.lib.packages."${system}".lib;
                [
                  {
                    xdg.configFile."sqlite3/sqliterc" = {
                      # https://sqlite.org/cli.html#changing_output_formats

                      text = ''
                        .mode list
                      '';
                    };
                  }
                  inputs.nix-colors.homeManagerModules.default
                  inputs.nix-index-database.hmModules.nix-index
                  #
                  # inputs.firefox.nixosModules.vaapi
                  inputs.firefox.nixosModules.basic
                  inputs.firefox.nixosModules.chromium.home
                  inputs.firefox.nixosModules.devtools
                  inputs.firefox.nixosModules.dns
                  inputs.firefox.nixosModules.extensions
                  inputs.firefox.nixosModules.main
                  inputs.firefox.nixosModules.media
                  inputs.firefox.nixosModules.newtabpage
                  inputs.firefox.nixosModules.privacy
                  inputs.firefox.nixosModules.tabs
                  inputs.firefox.nixosModules.telemetry
                  inputs.firefox.nixosModules.urlbar
                  inputs.fzf.nixosModules.home
                  inputs.git.nixosModules.home
                  inputs.lf.nixosModules.home
                  inputs.lua.nixosModules.common.home
                  inputs.lua.nixosModules.neovim.home
                  inputs.lua.nixosModules.vim.home
                  inputs.tmux.nixosModules.home
                  inputs.vim.nixosModules.home
                  inputs.vim.nixosModules.plugins.home
                  inputs.zsh.nixosModules.env.hm
                  inputs.zsh.nixosModules.hm
                  inputs.zsh.nixosModules.ff.bookmarks
                  ./rofi
                ]
                ++ i_ ./config
                ++ i_ ./programs
                ++ i_ ./services
                ++ i_ ./lua;
            };
          };
        }
      ];
    in
    {
      packages.x86_64-linux = {
        iso = inputs.nixos-generators.nixosGenerate {
          system = system;
          format = "iso"; # https://github.com/nix-community/nixos-generators#supported-formats
          modules = [
            {
              environment.systemPackages = [
                pkgs.vim
              ];
            }
          ];
        };
        vbox = inputs.nixos-generators.nixosGenerate {
          system = system;
          format = "virtualbox";
        };
      };
      checks."${system}".default = pkgs.testers.runNixOSTest {
        name = "self";
        nodes.machine = { ... }: { };
        testScript = builtins.readFile ./flake.test.py;
      };
      devShells."${system}".default = pkgs.mkShell { };
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
          ./dell
        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          inputs.nixos-hardware.nixosModules.common-hidpi
          ./pc.nix
          # ./pc_disks.nix

        ];
        specialArgs = { inherit inputs; };
      };
    };
}

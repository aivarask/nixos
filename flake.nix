{
  inputs = {

    # nixpkgs.url = "https://flakehub.com/f/NixOS/nipkgs/0.1.0.tar.gz";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
    browsers.url = "./browsers";
    browsers.inputs.nixpkgs.follows = "nixpkgs";
    git.url = "./_git";
    go.url = "./go";
    lib.url = "./lib";
    manix.url = "./manix";
    matrix.url = "./matrix";
    node.url = "./node";
    pistol.url = "./pistol";
    python.url = "./python";
    rust.url = "./rust";
    suckless.url = "./suckless";
    tmux.url = "./tmux";
    vim.url = "./lua";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayland.url = "./wayland";
    x11.url = "./x11";
    sh.url = "./sh";
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
          # inputs.browsers.overlays.default
        ];
      };
      commonModules = with inputs; [
        {
          # gestures
          # https://www.youtube.com/watch?v=qeVzPaBifPc
          # https://www.reddit.com/r/gnome/comments/td8irt/touchpad_gestures_in_chromechromium/
          # https://wiki.archlinux.org/title/Touchegg
          # https://mynixos.com/search?q=touchegg
          services.touchegg.enable = true;
        }
        {
          environment.systemPackages = [ pkgs.utf8proc ];
          nixpkgs.overlays = [
            # inputs.neovim-nightly-overlay.overlays.default
          ];
        }
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
        inputs.browsers.nixosModules.default
        inputs.git.nixosModules.default
        inputs.go.nixosModules.default
        inputs.lib.nixosModules.default
        inputs.manix.nixosModules.default
        inputs.matrix.nixosModules.default
        inputs.node.nixosModules.default
        inputs.pistol.nixosModules.default
        inputs.python.nixosModules.default
        inputs.rust.nixosModules.default
        inputs.suckless.nixosModules.default
        inputs.vim.nixosModules.default
        inputs.vim.nixosModules.lua
        inputs.x11.nixosModules.default
        inputs.sh.nixosModules.env.sys
        # inputs.aldale.nixosModules.default
        # inputs.aiva.nixosModules.default
        # inputs.wayland.nixosModules.default
        ./ollama.nix
        ./dialog
        ./xdg
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
                ./sql.nix
                ./playwright.nix
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
            verbose = true;
            sharedModules = [ ];
            extraSpecialArgs = {
              inherit inputs;
            };
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
                  inputs.nix-colors.homeManagerModules.default
                  inputs.nix-index-database.hmModules.nix-index
                  inputs.browsers.nixosModules.firefox
                  inputs.browsers.nixosModules.chromium
                  inputs.git.nixosModules.home
                  inputs.tmux.nixosModules.home
                  inputs.vim.nixosModules.commonPlugins
                  inputs.vim.nixosModules.vim
                  inputs.vim.nixosModules.neovim
                  inputs.vim.nixosModules.neovimPlugins
                  # inputs.vim.nixosModules.neovimOverlays
                  inputs.sh.nixosModules.env.hm
                  inputs.sh.nixosModules.sh
                  inputs.sh.nixosModules.fzf
                  inputs.x11.nixosModules.hm
                  ./htop
                  ./kitty
                  ./lf
                  ./mpv
                  ./ncmpcpp
                  ./sxhkd
                  #
                  ./rofi
                  ./sql_.nix
                  ./term/alacritty_.nix
                  ./term/wezterm_.nix
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
        modules = commonModules ++ [ ./dell ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [ ./pc ];
        specialArgs = { inherit inputs; };
      };
    };
}

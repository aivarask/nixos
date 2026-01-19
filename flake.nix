{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.systems.url = "github:nix-systems/x86_64-linux";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";
  inputs.nps.url = "github:OleMussmann/nps";
  inputs.nps.inputs.nixpkgs.follows = "nixpkgs";
  inputs.templates.url = "github:NixOS/templates";
  inputs.disko-templates.url = "github:nix-community/disko-templates";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # https://github.com/nixos/nixos-hardware
  inputs.nixos-generators.url = "github:nix-community/nixos-generators";
  inputs.nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager"; # https://github.com/nix-community/home-manager
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixgl.url = "github:nix-community/nixGL"; # https://github.com/nix-community/nixGL
  inputs.nix-colors.url = "github:misterio77/nix-colors";
  inputs.nix-index-database.url = "github:nix-community/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nur.url = "github:nix-community/NUR";
  inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.browser-previews.url = "github:nix-community/browser-previews";
  inputs.browser-previews.inputs.nixpkgs.follows = "nixpkgs";
  inputs.musnix.url = "github:musnix/musnix";
  inputs.rust-overlay.url = "github:oxalica/rust-overlay";
  #
  inputs.vim-log-highlighting.url = "github:MTDL9/vim-log-highlighting";
  inputs.vim-log-highlighting.flake = false;
  inputs.vim-interestingwords.url = "github:lfv89/vim-interestingwords";
  inputs.vim-interestingwords.flake = false;
  inputs.neotest-playwright.url = "github:thenbe/neotest-playwright";
  inputs.neotest-playwright.flake = false;
  inputs.persistent-breakpoints.url = "github:Weissle/persistent-breakpoints.nvim";
  inputs.persistent-breakpoints.flake = false;
  inputs.smart-semicolon.url = "github:iagotito/smart-semicolon.nvim";
  inputs.smart-semicolon.flake = false;
  inputs.one-small-step-for-vimkind.url = "github:jbyuki/one-small-step-for-vimkind";
  inputs.one-small-step-for-vimkind.flake = false;
  inputs.websocket-nvim.url = "github:samsze0/websocket.nvim";
  inputs.websocket-nvim.flake = false;
  inputs.nvim-oxi.url = "github:noib3/nvim-oxi";
  inputs.nvim-oxi.flake = false;
  # https://github.com/mlua-rs/mlua
  outputs =
    { nixpkgs, ... }@inputs:
    let
      commonModules = [
        (import ./audio/mpd.nix).system
        (import ./sway).system
        ./audio/pipewire.nix
        ./audio/production.nix
        ./common/config.nix
        ./common/environment.nix
        ./common/network/networking.nix
        ./common/network/wireless.nix
        ./common/nix.nix
        ./common/nps.nix
        ./common/samba.nix
        ./common/services.nix
        ./httpd
        ./lang/go.nix
        ./lang/nodejs.nix
        ./lang/python
        ./lang/sql.nix
        ./lib.nix
        ./lua
        (
          { pkgs, ... }:
          {
            systemd.sleep.extraConfig = ''
              HibernateDelaySec=1h
            '';

            environment.systemPackages = with pkgs; [
              git
              systemctl-tui
              sysz
              gdu
              duf

              incus
              buildah
              podman
              skopeo
              podman-tui
              # MTP (Media transfer protocol)
              # https://nixos.wiki/wiki/MTP
              # https://wiki.archlinux.org/title/Media_Transfer_Protocol
              # lsusb
              # gio mount "mtp://[usb:001,006]/"
              # mtpfs
              # simple-mtpfs
              # go-mtpfs
              jmtpfs
              android-file-transfer

              inotify-tools
              fswatch

              udiskie
              parted
              gparted
            ];
          }
        )
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            extraSpecialArgs = {
              SELF = "/etc/nixos";
              inherit inputs;
            };
            sharedModules = [ { home.stateVersion = "23.05"; } ];

            users.root = {
              home.username = "root";
              home.homeDirectory = "/root";
              home.enableNixpkgsReleaseCheck = false;
              manual.json.enable = true;
              programs.man.generateCaches = true;
              colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
              services.mpris-proxy.enable = true;
              services.udiskie.enable = true;
              imports = [
                inputs.nix-colors.homeManagerModules.default
                inputs.nix-index-database.homeModules.nix-index
                ./.espanso.nix
                ./.programs.nix
                ./browsers/chromium-browser.nix
                ./browsers/firefox.nix
                ./lua/default_hm.nix
                (
                  { pkgs, ... }:
                  {
                    services.gammastep.enable = true;
                    services.gammastep.latitude = 54.0;
                    services.gammastep.longitude = 25.0;
                    services.gammastep.temperature = {
                      day = 6500; # 5500
                      night = 4500; # 3700
                    };
                  }
                )

              ];
            };
          };
        }
      ];
    in
    inputs.flake-utils.lib.eachDefaultSystem (system: {

      # checks./*<SYSTEM>.*/"<CHECK>" = /* ... */;
      # devShells./*<SYSTEM>.*/"<DEV_SHELL>" = /* ... */;
      # packages./*<SYSTEM>.*/"<PACKAGE>" = /* ... */;
    })
    // inputs.flake-utils.lib.eachDefaultSystemPassThrough (system: {
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixfmt-tree;
      packages."${system}" = {
        minimal_iso = inputs.nixos-generators.nixosGenerate {
          inherit system;
          modules = [
          ];
          format = "install-iso";

          # optional arguments:
          # explicit nixpkgs and lib:
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          # lib = nixpkgs.legacyPackages.x86_64-linux.lib;
          # additional arguments to pass to modules:
          # specialArgs = { myExtraArg = "foobar"; };

          # you can also define your own custom formats
          # customFormats = { "myFormat" = <myFormatModule>; ... };
          # format = "myFormat";
        };
        # vbox = inputs.nixos-generators.nixosGenerate {
        #   system = "x86_64-linux";
        #   format = "virtualbox";
        # };
      };

      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [ ./common/dell ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [ ./common/pc ];
        specialArgs = { inherit inputs; };
      };
    });
}

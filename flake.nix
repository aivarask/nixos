{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.systems.url = "github:nix-systems/x86_64-linux";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";
  inputs.nps.url = "github:OleMussmann/nps";
  inputs.nps.inputs.nixpkgs.follows = "nixpkgs";
  inputs.templates.url = "github:NixOS/templates";
  inputs.dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
  inputs.disko-templates.url = "github:nix-community/disko-templates";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.nixos-generators.url = "github:nix-community/nixos-generators";
  inputs.nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixgl.url = "github:nix-community/nixGL";
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
  inputs.LS_COLORS.url = "github:trapd00r/LS_COLORS";
  inputs.LS_COLORS.flake = false;
  #
  inputs.sxiv-tabbed.url = "github:bakkeby/sxiv-flexipatch";
  inputs.sxiv-tabbed.flake = false;
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
  inputs.tree-sitter-language-injection.url = "github:DariusCorvus/tree-sitter-language-injection.nvim";
  inputs.tree-sitter-language-injection.flake = false;
  inputs.websocket-nvim.url = "github:samsze0/websocket.nvim";
  inputs.websocket-nvim.flake = false;
  inputs.nvim-oxi.url = "github:noib3/nvim-oxi";
  inputs.nvim-oxi.flake = false;
  inputs.strudel-nvim.url = "https://github.com/gruvw/strudel.nvim";
  inputs.strudel-nvim.flake = false;
  # https://github.com/mlua-rs/mlua
  outputs =
    { nixpkgs, ... }@inputs:
    let
      commonModules = [
        (import ./sway).system
        (import ./audio/mpd.nix).system
        ./audio/pipewire.nix
        ./audio/production.nix
        ./common/config.nix
        ./common/nix.nix
        ./common/nps.nix
        ./common/services.nix
        (import ./env.nix).system
        ./httpd
        ./lang/go.nix
        ./lang/nodejs.nix
        ./lang/python
        ./lang/sql.nix
        ./lib.nix
        ./lua
        # ./network/dns_basic.nix
        ./network/networking.nix
        ./network/wireless.nix
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = with inputs; [ (_: _: { inherit LS_COLORS; }) ];
            systemd.sleep.extraConfig = ''
              HibernateDelaySec=1h
            '';

            environment.systemPackages = with pkgs; [
              git
              systemctl-tui
              sysz
              gdu
              duf

              # MTP (Media transfer protocol)
              # https://nixos.wiki/wiki/MTP
              # https://wiki.archlinux.org/title/Media_Transfer_Protocol
              # lsusb
              # gio mount "mtp://[usb:001,006]/"
              mtpfs
              simple-mtpfs
              go-mtpfs
              jmtpfs
              android-file-transfer

              inotify-tools
              fswatch

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

            users.root = rec {
              home.username = "root";
              home.homeDirectory = "/root";
              home.enableNixpkgsReleaseCheck = false;
              manual.json.enable = true;
              programs.man.generateCaches = true;
              colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
              services.mpris-proxy.enable = true;
              imports = [
                inputs.nix-colors.homeManagerModules.default
                inputs.nix-index-database.homeModules.nix-index
                (import ./env.nix).hm
                ./.programs.nix
                # ./browsers/chromium.nix
                ./browsers/fire.nix
                ./lua/default_hm.nix
                # Chrome
                (
                  { pkgs, ... }:
                  {
                    home.sessionVariables.NIXOS_OZONE_WL = "1";
                    # home.packages = with pkgs; [
                    #   (chromium.override {
                    #     # extensions = [ ];
                    #     enableWideVine = true;
                    #     commandLineArgs = [
                    #       "--enable-features=AcceleratedVideoEncoder"
                    #       "--ignore-gpu-blocklist"
                    #       "--enable-zero-copy"
                    #     ];
                    #     extraOpts = {
                    #       "BrowserSignin" = 0;
                    #       "SyncDisabled" = true;
                    #       "PasswordManagerEnabled" = false;
                    #       "SpellcheckEnabled" = true;
                    #       "SpellcheckLanguage" = [
                    #         "lt"
                    #         "en-US"
                    #       ];
                    #     };
                    #   })
                    # ];

                    programs.chromium = {
                      enable = true;
                      # homepageLocation = "https://www.startpage.com/";
                      commandLineArgs = [
                        "--no-sandbox"
                        "--enable-features=AcceleratedVideoEncoder"
                        "--ignore-gpu-blocklist"
                        "--enable-zero-copy"
                      ];
                      extensions = [
                        # "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx" # dark reader
                        # "aapbdbdomjkkjkaonfhkkikfgjllcleb;https://clients2.google.com/service/update2/crx" # google translate
                        "mlomiejdfkolichcflejclcbmpeaniij" # ghostery
                      ];
                    };
                  }
                )
                # Firefox

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
        modules = commonModules ++ [ ./hosts/dell ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [ ./hosts/pc ];
        specialArgs = { inherit inputs; };
      };
    });
}

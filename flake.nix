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
  inputs.dmenu-flexipatch.url = "github:bakkeby/dmenu-flexipatch";
  inputs.dmenu-flexipatch.flake = false;
  inputs.dwm-flexipatch.url = "github:bakkeby/dwm-flexipatch";
  inputs.dwm-flexipatch.flake = false;
  inputs.st-flexipatch.url = "github:bakkeby/st-flexipatch";
  inputs.st-flexipatch.flake = false;
  inputs.tabbed-flexipatch.url = "github:bakkeby/tabbed-flexipatch";
  inputs.tabbed-flexipatch.flake = false;
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
                # ./browsers/firefox.nix
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
                (
                  {
                    pkgs,
                    lib,
                    ...
                  }:
                  {

                    programs.firefox = {
                      enable = true;

                      languagePacks = [
                        "en-US"
                        "lt"
                      ];

                      policies = {
                        # Updates & Background Services
                        AppAutoUpdate = false;
                        BackgroundAppUpdate = false;

                        # Feature Disabling
                        DisableBuiltinPDFViewer = true;
                        DisableFirefoxStudies = true;
                        DisableFirefoxAccounts = true;
                        DisableFirefoxScreenshots = true;
                        DisableForgetButton = true;
                        DisableMasterPasswordCreation = true;
                        DisableProfileImport = true;
                        DisableProfileRefresh = true;
                        DisableSetDesktopBackground = true;
                        DisablePocket = true;
                        DisableTelemetry = true;
                        DisableFormHistory = true;
                        DisablePasswordReveal = true;

                        # Access Restrictions
                        BlockAboutConfig = false;
                        BlockAboutProfiles = true;
                        BlockAboutSupport = false;

                        # UI and Behavior
                        DisplayMenuBar = "never";
                        DontCheckDefaultBrowser = true;
                        HardwareAcceleration = true;
                        OfferToSaveLogins = false;
                        DefaultDownloadDirectory = "${home.homeDirectory}/Downloads";

                        # Extensions
                        ExtensionSettings =
                          let
                            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
                          in
                          {
                            "*".installation_mode = "blocked";

                            "uBlock0@raymondhill.net" = {
                              install_url = moz "ublock-origin";
                              installation_mode = "force_installed";
                              updates_disabled = true;
                            };

                            "{f3b4b962-34b4-4935-9eee-45b0bce58279}" = {
                              install_url = moz "animated-purple-moon-lake";
                              installation_mode = "force_installed";
                              updates_disabled = true;
                            };

                            "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
                              install_url = moz "noscript";
                              installation_mode = "force_installed";
                              updates_disabled = true;
                            };

                            "3rdparty".Extensions = {
                              "uBlock0@raymondhill.net".adminSettings = {
                                userSettings = rec {
                                  uiTheme = "dark";
                                  uiAccentCustom = true;
                                  uiAccentCustom0 = "#8300ff";
                                  cloudStorageEnabled = lib.mkForce false;

                                  importedLists = [
                                    "https:#filters.adtidy.org/extension/ublock/filters/3.txt"
                                    "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                                  ];

                                  externalLists = lib.concatStringsSep "\n" importedLists;
                                };

                                selectedFilterLists = [
                                  "CZE-0"
                                  "adguard-generic"
                                  "adguard-annoyance"
                                  "adguard-social"
                                  "adguard-spyware-url"
                                  "easylist"
                                  "easyprivacy"
                                  "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                                  "plowe-0"
                                  "ublock-abuse"
                                  "ublock-badware"
                                  "ublock-filters"
                                  "ublock-privacy"
                                  "ublock-quick-fixes"
                                  "ublock-unbreak"
                                  "urlhaus-1"
                                ];
                              };
                            };
                          };
                      };

                      profiles.default.search = {
                        force = true;
                        default = "ddg";
                        privateDefault = "ddg";

                        engines = {
                          "Nix Packages" = {
                            urls = [
                              {
                                template = "https://search.nixos.org/packages";
                                params = [
                                  {
                                    name = "channel";
                                    value = "unstable";
                                  }
                                  {
                                    name = "query";
                                    value = "{searchTerms}";
                                  }
                                ];
                              }
                            ];
                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            definedAliases = [ "@np" ];
                          };

                          "Nix Options" = {
                            urls = [
                              {
                                template = "https://search.nixos.org/options";
                                params = [
                                  {
                                    name = "channel";
                                    value = "unstable";
                                  }
                                  {
                                    name = "query";
                                    value = "{searchTerms}";
                                  }
                                ];
                              }
                            ];
                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            definedAliases = [ "@no" ];
                          };

                          "NixOS Wiki" = {
                            urls = [
                              {
                                template = "https://wiki.nixos.org/w/index.php";
                                params = [
                                  {
                                    name = "search";
                                    value = "{searchTerms}";
                                  }
                                ];
                              }
                            ];
                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            definedAliases = [ "@nw" ];
                          };
                        };
                      };
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

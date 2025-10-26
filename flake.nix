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
  inputs.sxhkd-vim.url = "github:kovetskiy/sxhkd-vim";
  inputs.sxhkd-vim.flake = false;
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
  # https://github.com/mlua-rs/mlua
  outputs =
    { nixpkgs, ... }@inputs:
    let
      commonModules = [
        (import ./audio/mpd.nix).system
        ./audio/pipewire.nix
        ./audio/production.nix
        ./config
        ./config/documentation.nix
        ./config/environment.nix
        ./config/fonts.nix
        ./config/i18n.nix
        ./config/nix.nix
        ./go
        ./httpd
        ./lib
        ./lnav
        ./LS_COLORS.nix
        ./lua
        # ./network/dns_basic.nix
        ./network/networking.nix
        ./network/wireless.nix
        ./node
        ./nps.nix
        ./programs
        ./python
        ./services
        ./services/deskflow.nix
        ./services/dwm-status.nix
        ./services/kmscon.nix
        ./services/maddy.nix
        ./services/nginx.nix
        ./services/openssh.nix
        ./services/redshift.nix
        ./services/transmission.nix
        ./services/unclutter.nix
        ./sql/sql.nix
        ./suckless
        ./systemd/music.nix
        ./systemd/remote-touchpad.nix
        ./systemd/video.nix
        ./steam
        ./touchegg
        ./virt/virtualbox.nix
        ./wallpaper
        (
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
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
        (import ./llm.nix).system
        (import ./users/aiva.nix).system
        (import ./spotify.nix).system
        (import ./sh/env.nix).system
        (import ./x11).default
        (import ./yt-dlp).system
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = rec {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            extraSpecialArgs = {
              SELF = "/etc/nixos";
              inherit inputs;
            };
            sharedModules = [ { home.stateVersion = "23.05"; } ];
            users.aiva = users.root // {
              home.username = "aiva";
              home.homeDirectory = "/home/aiva";
            };

            users.root = {
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

                ./git
                ./awesome
                ./audio/hm.nix
                ./audio/nicotine.nix
                ./browsers/chromium.nix
                ./browsers/firefox.nix
                ./htop
                ./kitty
                ./lf
                ./lua/default_hm.nix
                ./mpv
                ./ncmpcpp
                ./picom/hm_.nix
                ./programs/direnv_.nix
                ./programs/default_.nix
                ./programs/gh_.nix
                ./programs/nixindex_.nix
                ./rofi
                ./services/dunst_.nix
                ./sh/bat.nix
                ./sh/fzf.nix
                ./sh/pistol.nix
                ./sh/starship.nix
                ./sh/zsh.nix
                ./sql/sql_.nix
                ./sxhkd
                (import ./term/alacritty.nix).home-manager
                (import ./term/wezterm.nix).home-manager
                ./tmux
                ./touchegg/hm_.nix
                (import ./users/aiva.nix).hm
                (import ./sh/env.nix).hm
                (import ./x11).hm
                (import ./x11/notify.nix).hm
                (import ./yt-dlp).home-manager
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
            ./minimal.nix
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
        modules = commonModules ++ [ ./dell ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [ ./pc ];
        specialArgs = { inherit inputs; };
      };
    });
}

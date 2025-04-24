{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nps.url = "github:OleMussmann/nps";
    nps.inputs.nixpkgs.follows = "nixpkgs";
    templates.url = "github:NixOS/templates";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    LS_COLORS.url = "github:trapd00r/LS_COLORS";
    LS_COLORS.flake = false;
    browser-previews.url = "github:nix-community/browser-previews";
    browser-previews.inputs.nixpkgs.follows = "nixpkgs";
    musnix.url = "github:musnix/musnix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    #
    dmenu-flexipatch.url = "github:bakkeby/dmenu-flexipatch";
    dmenu-flexipatch.flake = false;
    dwm-flexipatch.url = "github:bakkeby/dwm-flexipatch";
    dwm-flexipatch.flake = false;
    st-flexipatch.url = "github:bakkeby/st-flexipatch";
    st-flexipatch.flake = false;
    tabbed-flexipatch.url = "github:bakkeby/tabbed-flexipatch";
    tabbed-flexipatch.flake = false;
    sxiv-tabbed.url = "github:bakkeby/sxiv-flexipatch";
    sxiv-tabbed.flake = false;
    #
    sxhkd-vim.url = "github:kovetskiy/sxhkd-vim";
    sxhkd-vim.flake = false;
    vim-log-highlighting.url = "github:MTDL9/vim-log-highlighting";
    vim-log-highlighting.flake = false;
    vim-interestingwords.url = "github:lfv89/vim-interestingwords";
    vim-interestingwords.flake = false;
    neotest-playwright.url = "github:thenbe/neotest-playwright";
    neotest-playwright.flake = false;
    persistent-breakpoints.url = "github:Weissle/persistent-breakpoints.nvim";
    persistent-breakpoints.flake = false;
    smart-semicolon.url = "github:iagotito/smart-semicolon.nvim";
    smart-semicolon.flake = false;
    one-small-step-for-vimkind.url = "github:jbyuki/one-small-step-for-vimkind";
    one-small-step-for-vimkind.flake = false;
    tree-sitter-language-injection.url = "github:DariusCorvus/tree-sitter-language-injection.nvim";
    tree-sitter-language-injection.flake = false;
    websocket-nvim.url = "github:samsze0/websocket.nvim";
    websocket-nvim.flake = false;
    nvim-oxi.url = "github:noib3/nvim-oxi";
    nvim-oxi.flake = false;
    # https://github.com/mlua-rs/mlua
  };
  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      commonModules = with inputs; [
        (
          { pkgs, ... }:
          {
            environment.systemPackages = [
              pkgs.utf8proc
              # pkgs.git
            ];
          }
        )
        {
          # gestures
          # https://www.youtube.com/watch?v=qeVzPaBifPc
          # https://www.reddit.com/r/gnome/comments/td8irt/touchpad_gestures_in_chromechromium/
          # https://wiki.archlinux.org/title/Touchegg
          # https://mynixos.com/search?q=touchegg
          services.touchegg.enable = true;
        }
        ./audio/pipewire.nix
        ./audio/mpd.nix
        ./audio/production.nix
        ./go
        ./lua
        ./node
        ./python
        ./sh/env.nix
        ./suckless
        ./sql/sql.nix
        ./ollama.nix
        ./dialog
        ./x11
        ./xdg
        {
          imports = [
            ./lnav
            ./systemd/remote-touchpad.nix
            ./systemd/music.nix
            ./systemd/video.nix
            ./virt/virtualbox.nix
            ./wallpaper
            ./playwright.nix
            #
            ./config
            ./config/documentation.nix
            ./config/environment.nix
            ./config/fonts.nix
            ./config/i18n.nix
            ./config/nix.nix
            #
            ./network/networking.nix
            ./network/networkingwireless.nix
            #
            ./programs
            #
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
          ];
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            verbose = true;
            sharedModules = [
              {
                home.stateVersion = "23.05";
              }
            ];
            extraSpecialArgs = {
              inherit inputs;
              SELF = "/etc/nixos";
            };
            users.root = {
              home.username = "root";
              home.homeDirectory = "/root";
              home.enableNixpkgsReleaseCheck = false;
              manual.json.enable = true;
              programs.man.generateCaches = true;
              colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
              services.mpris-proxy.enable = true; # https://specifications.freedesktop.org/mpris-spec/latest/
              # services.blueman-applet.enable = true;
              imports = [
                inputs.nix-colors.homeManagerModules.default
                inputs.nix-index-database.hmModules.nix-index
                ./_git
                ./awesome
                ./browsers/chromium.nix
                ./browsers/firefox.nix
                ./htop
                ./kitty
                ./lf
                ./lua/vim.nix
                ./lua/nvim.nix
                ./lua/common_plugins.nix
                ./lua/nvim_plugins.nix
                ./lua/nvim_over.nix
                ./mpv
                ./ncmpcpp
                ./sxhkd
                ./sh/bat.nix
                ./sh/env_hm.nix
                ./sh/fzf.nix
                ./sh/pistol.nix
                ./sh/starship.nix
                ./sh/zsh.nix
                #
                ./rofi
                ./sql/sql_.nix
                ./term/alacritty_.nix
                ./term/wezterm_.nix
                #
                ./config/hm_.nix
                ./programs/default_.nix
                ./programs/direnv_.nix
                ./programs/gh_.nix
                ./programs/lazygit_.nix
                ./programs/nicotine_.nix
                ./programs/nixindex_.nix
                ./x11/hm_.nix
              ];
            };
          };
        }
      ];
    in
    {
      # formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules =
          [
            ./LS_COLORS.nix
            ./nps.nix
            ./lib
          ]
          ++ commonModules
          ++ [ ./dell ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [ ./pc ];
        specialArgs = { inherit inputs; };
      };
    };
}

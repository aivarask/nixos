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
    audio.url = "/etc/nixos/audio";
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git.url = "./_git";
    go.url = "./go";
    lib.url = "./lib";
    manix.url = "./manix";
    matrix.url = "./matrix";
    node.url = "./node";
    python.url = "./python";
    rust.url = "./rust";
    suckless.url = "./suckless";
    tmux.url = "./tmux";
    vim.url = "./lua";
    wayland.url = "./wayland";
    x11.url = "./x11";
    sh.url = "./sh";
    #
    # aldale.url = "./aldale";
    # aiva.url = "./aiva";
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
              pkgs.git
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
        inputs.audio.nixosModules.mpd
        inputs.audio.nixosModules.pipewire
        inputs.audio.nixosModules.production
        inputs.git.nixosModules.default
        inputs.go.nixosModules.default
        inputs.lib.nixosModules.default
        inputs.manix.nixosModules.default
        inputs.matrix.nixosModules.default
        inputs.node.nixosModules.default
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
        ./sql/sql.nix
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
              imports =
                with inputs.lib.packages."${system}".lib;
                [
                  inputs.nix-colors.homeManagerModules.default
                  inputs.nix-index-database.hmModules.nix-index
                  inputs.git.nixosModules.home
                  inputs.tmux.nixosModules.home
                  inputs.vim.nixosModules.commonPlugins
                  inputs.vim.nixosModules.vim
                  inputs.vim.nixosModules.neovim
                  inputs.vim.nixosModules.neovimPlugins
                  # inputs.vim.nixosModules.neovimOverlays
                  inputs.sh.nixosModules.env.hm
                  inputs.sh.nixosModules.zsh
                  inputs.sh.nixosModules.bat
                  inputs.sh.nixosModules.pistol
                  inputs.sh.nixosModules.fzf
                  inputs.sh.nixosModules.starship
                  inputs.x11.nixosModules.hm
                  ./browsers/chromium.nix
                  ./browsers/firefox.nix
                  ./htop
                  ./kitty
                  ./lf
                  ./mpv
                  ./ncmpcpp
                  ./sxhkd
                  #
                  ./rofi
                  ./sql/sql_.nix
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
      # formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules =
          [
            ./LS_COLORS.nix
            ./nps.nix
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

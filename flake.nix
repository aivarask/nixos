{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.systems.url = "github:nix-systems/x86_64-linux";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";
  inputs.nps.url = "github:OleMussmann/nps";
  inputs.nps.inputs.nixpkgs.follows = "nixpkgs";
  inputs.templates.url = "github:NixOS/templates";
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
        inputs.disko.nixosModules.disko
        ./audio/mpd.nix
        ./audio/pipewire.nix
        ./audio/production.nix
        ./common/config.nix
        ./common/environment.nix
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
        ./sway
        (
          { pkgs, ... }:
          {

            services.playerctld.enable = true;
            # services.mpris-proxy.enable = true;
            # services.udiskie.enable = true;
            services.espanso.enable = true;
            services.espanso.package = pkgs.espanso-wayland;

            systemd.sleep.extraConfig = ''
              HibernateDelaySec=1h
            '';

            environment.systemPackages = with pkgs; [
              nixos-anywhere # https://github.com/nix-community/nixos-anywhere
              # https://github.com/nix-community/nixos-anywhere/blob/main/docs/reference.md
              disko
              qemu

              git
              systemctl-tui
              sysz
              gdu
              duf
              dust

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
              imports = [
                inputs.nix-colors.homeManagerModules.default
                inputs.nix-index-database.homeModules.nix-index
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
        common_iso = inputs.nixos-generators.nixosGenerate {
          inherit system;
          modules = commonModules;
          format = "install-iso";
          specialArgs = { inherit inputs; };
        };
        dell_iso = inputs.nixos-generators.nixosGenerate {
          inherit system;
          modules = commonModules ++ [ ./common/dell ];
          format = "install-iso";
          specialArgs = { inherit inputs; };
        };
      };
      # https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
      # wireless https://nixos.org/manual/nixos/stable/index.html#sec-building-image-drivers

      nixosConfigurations.exampleIso = nixpkgs.lib.nixosSystem {
        # build nix build .\#nixosConfigurations.exampleIso.config.system.build.isoImage
        # test https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Testing_the_image
        # emulate qemu-system-x86_64 -enable-kvm -m 256 -cdrom result/iso/nixos-*.iso
        #     https://wiki.nixos.org/wiki/QEMU
        # build nix build .\#nixosConfigurations.exampleIso.config.system.build.isoImage &&
        # partition
        # UEFI(GPT) https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-UEFI
        # format https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-formatting
        # install https://nixos.org/manual/nixos/stable/#sec-installation-manual-installing
        inherit system;
        modules = [
          (
            {
              pkgs,
              modulesPath,
              config,
              lib,
              ...
            }:
            {
              # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/cd-dvd
              imports = [
                (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
                (modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")
                # (modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
              ];
              environment.systemPackages = with pkgs; [
                systemctl-tui
                fzf
                neovim
                disko
                htop
              ];
              # customization
              programs.bash.interactiveShellInit = ''
                shopt -s autocd
                # shopt -s autocd
              '';
              # dns https://wiki.nixos.org/wiki/NetworkManager#DNS_Management
              networking.networkmanager.wifi.backend = "wpa_supplicant";
              # SSH https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#SSH
              systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
              users.users.root.openssh.authorizedKeys.keys = [
                # "ssh-ed25519 AaAeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee username@host"
              ];
              # static_ip https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Static_IP_Address
              # networking = lib.mkIf false {
              #   usePredictableInterfaceNames = false;
              #   interfaces.eth0.ipv4.addresses = [
              #     {
              #       address = "192.168.1.100";
              #       prefixLength = 24;
              #     }
              #   ];
              #   defaultGateway = "192.168.1.1";
              #   nameservers = [ "8.8.8.8" ];
              # };
              # compression https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Building_faster
              # squashfsCompression 	Time 	Size
              # lz4 	100s 	59%
              # gzip -Xcompression-level 1 	105s 	52%
              # gzip 	210s 	49%
              # xz -Xdict-size 100% (default) 	450s 	43%
              isoImage.squashfsCompression = "gzip -Xcompression-level 1";

              # wifi https://nixos.org/manual/nixos/stable/index.html#sec-building-image-drivers
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.permittedInsecurePackages = [
                "broadcom-sta-6.30.223.271-59-6.18.3"
              ];

              boot.initrd.kernelModules = [ "wl" ];
              boot.kernelModules = [
                "kvm-intel"
                "wl"
              ];
              boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

            }
          )
        ];
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

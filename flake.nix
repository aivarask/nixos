{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.systems.url = "github:nix-systems/x86_64-linux";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";

  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # https://github.com/nixos/nixos-hardware
  inputs.home-manager.url = "github:nix-community/home-manager"; # https://github.com/nix-community/home-manager
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-colors.url = "github:misterio77/nix-colors";
  inputs.nix-index-database.url = "github:nix-community/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nur.url = "github:nix-community/NUR";
  inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  inputs.musnix.url = "github:musnix/musnix";
  #
  inputs.smart-semicolon.url = "github:iagotito/smart-semicolon.nvim";
  inputs.smart-semicolon.flake = false;
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      commonModules = [
        inputs.disko.nixosModules.disko
        ./audio/mpd.nix
        ./audio/pipewire.nix
        # ./audio/production.nix
        ./common/config.nix
        ./common/environment.nix
        ./common/nix.nix
        ./services.nix
        ./httpd
        ./lua
        ./sway
        (
          { pkgs, ... }:
          {

            systemd.sleep.extraConfig = ''
              HibernateDelaySec=1h
            '';

            environment.systemPackages = with pkgs; [
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
                ./.programs.nix
                ./browsers/chromium-browser.nix
                ./browsers/firefox.nix
                ./lua/default_hm.nix
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
      nixpkgs.hostPlatform = system;
      packages."${system}" = { };

      nixosConfigurations.iso-minimal = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self; };
        modules = [
          ./iso.nix
          ./minimal.nix
        ];
      };
      nixosConfigurations.minimal = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self; };
        modules = commonModules ++ [
          (
            {
              modulesPath,
              lib,
              config,
              ...
            }:
            {
              networking.hostName = "minimal";
              imports = [
                (modulesPath + "/installer/scan/not-detected.nix")
                (modulesPath + "/installer/cd-dvd/latest-kernel.nix")
                ./minimal.nix
                ./autologin.nix
                ./search.nix
                ./bluetooth.nix
                # inputs.disko.nixosModules.disko
                # ./disk-nvme.nix
              ];
              boot.loader.systemd-boot.enable = true;
              boot.loader.efi.canTouchEfiVariables = true;
              # boot.loader.grub.enable = true;
              # boot.loader.grub.efiSupport = true;
              # boot.loader.grub.efiInstallAsRemovable = true;

              # hardware
              boot.initrd.availableKernelModules = [
                "nvme"
                "xhci_pci"
                "ahci"
                "usbhid"
                "usb_storage"
                "sd_mod"
              ];
              boot.initrd.kernelModules = [ "wl" ];
              boot.kernelModules = [ "kvm-intel" ];
              system.stateVersion = "26.05";
              nixpkgs.hostPlatform = system; # lib.mkDefault "x86_64-linux";
              hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
              fileSystems."/" = {
                device = "/dev/disk/by-partlabel/disk-main-root";
                fsType = "ext4";
              };
              fileSystems."/boot" = {
                device = "/dev/disk/by-partlabel/disk-main-ESP";
                fsType = "vfat";
                options = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };

            }
          )
        ];
      };
      nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          ./common/pc.nix
          ./autologin.nix
          ./search.nix
        ];
        specialArgs = { inherit inputs; };
      };
    });
}

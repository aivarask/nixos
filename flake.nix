{
  # nixos-generators
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nur.url = "github:nix-community/NUR";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # aivarask
    slstatus.url = "github:aivarask/slstatus";
    dwm-flexipatch.url = "github:aivarask/dwm-flexipatch";
    dmenu-flexipatch.url = "github:aivarask/dmenu-flexipatch";
    st-flexipatch.url = "github:aivarask/st-flexipatch";
    tabbed-flexipatch.url = "github:aivarask/tabbed-flexipatch";
    # other
    LS_COLORS = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
    vim.url = "path:./vim";
    musnix = { url = "github:musnix/musnix"; };
  };
  outputs =
    { nixpkgs
    , home-manager
    , nixos-hardware
    , ...
    } @ inputs:
    let
      overlays = with inputs; [
        rust-overlay.overlays.default
        nur.overlay
        neovim-nightly-overlay.overlay
        slstatus.overlays.default
        st-flexipatch.overlays.default
        tabbed-flexipatch.overlays.default
        dwm-flexipatch.overlays.default
        dmenu-flexipatch.overlays.default

        # https://nixos.org/manual/nixpkgs/unstable/#ssec-language-go
        (final: prev: with prev; {
          inherit LS_COLORS;
        })
        vim.overlays.default
      ];
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = { };
      formatter."${system}" = pkgs.nixpkgs-fmt;

      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          # DELL XPS 7590
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./_dell.nix
            ./_audio.nix
            inputs.musnix.nixosModules.musnix
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = false;
                users.root = import ./home/_dell.nix;
              };
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        pc = nixpkgs.lib.nixosSystem {
          # PC B450 AORUS M
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./_pc.nix
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = import ./home/_pc.nix;
              };
            }
          ];
        };
      };
    };
}

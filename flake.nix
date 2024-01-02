{
  description = "NixOS config";
  inputs = {
    # Go related
    templ.url = "github:a-h/templ";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-mguentner.url = "github:mguentner/nixpkgs/playwright_1_30_0";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    statix.url = "github:nerdypepper/statix";
    nil.url = "github:oxalica/nil";
    prisma.url = "github:pimeys/nixos-prisma";
    # aivarask
    # aiva.url = "path:./overlays/aiva";
    slstatus.url = "github:aivarask/slstatus";
    dwm-flexipatch.url = "github:aivarask/dwm-flexipatch";
    dmenu-flexipatch.url = "github:aivarask/dmenu-flexipatch";
    st-flexipatch.url = "github:aivarask/st-flexipatch";
    tabbed-flexipatch.url = "github:aivarask/tabbed-flexipatch";
    # other
    devshell.url = "github:numtide/devshell";
    LS_COLORS = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
    # vim.url = "path:./vim";
    vim.url = "gitlab:aivarask/vim";
    musnix = { url = "github:musnix/musnix"; };
  };
  outputs =
    { nixpkgs
    , # nixpkgs-master,
      nixos-hardware
    , home-manager
    , # nixpkgs-mguentner,
      musnix
    , ...
    } @ inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      # mkPkgs = pkgs: extraOverlays:
      #   import pkgs {
      #     inherit system;
      #     config.allowUnfree = true; # forgive me Stallman senpai
      #     overlays = extraOverlays;
      #   };
      # master = mkPkgs nixpkgs-master [];
      # mguentner = mkPkgs nixpkgs-mguentner [];
      overlays = with inputs; [
        # (final: prev: {
        #   inherit
        #     (mguentner)
        #     playwright
        #     ;
        #   inherit mguentner;
        # })
        templ.overlays.default
        rust-overlay.overlays.default
        nur.overlay
        neovim-nightly-overlay.overlay
        slstatus.overlays.default
        st-flexipatch.overlays.default
        tabbed-flexipatch.overlays.default
        dwm-flexipatch.overlays.default
        dmenu-flexipatch.overlays.default
        nil.overlays.default
        prisma.overlay

        (_self: _super: { inherit LS_COLORS; })
        (import ./overlays/python.nix)
        vim.overlays.default
      ];
      home = import ./home;
    in
    {
      packages.${system} = {
        iso = inputs.nixos-generators.nixosGenerate {
          inherit system;
          # modules = [./configuration.nix];
          format = "iso";
        };
      };
      formatter."${system}" = nixpkgs.legacyPackages."${system}".alejandra;

      # PC B450 AORUS M
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
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
            { nixpkgs.overlays = overlays; }
            { nix.registry.nixpkgs.flake = nixpkgs; }
          ];
        };

        # DELL XPS 7590
        dell = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./_dell.nix
            musnix.nixosModules.musnix
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = import ./home/_dell.nix;
              };
            }
            { nixpkgs.overlays = overlays; }
            { nix.registry.nixpkgs.flake = nixpkgs; }
          ];
        };

        as = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./_as.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = import ./home/_as.nix;
                users.vytas = import ./home/_as.nix;
              };
            }
            { nixpkgs.overlays = overlays; }
            { nix.registry.nixpkgs.flake = nixpkgs; }
          ];
        };
      };
    };
}

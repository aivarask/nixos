{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
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
    gow = { url = "github:mitranim/gow"; flake = false; };
    echo = { url = "github:labstack/echo"; flake = false; };
  };
  outputs =
    { nixpkgs
    , nixos-hardware
    , home-manager
    , musnix
    , ...
    } @ inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      overlays = with inputs; [
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

        # https://nixos.org/manual/nixpkgs/unstable/#ssec-language-go
        (final: prev: with prev; {
          inherit LS_COLORS;
          gow = buildGoModule {
            name = "gow";
            src = inputs.gow;
            vendorHash = "sha256-Xw9V7bYaSfu5kA2505wmef2Ns/Y0RHKbZHUkvCtVNSM=";
            meta = with lib; {
              description = ''
                Missing watch mode for Go commands. Watch Go files and execute a command like "go run" or "go test"
              '';
              homepage = "https://github.com/mitranim/gow";
              license = licenses.unlicense;
            };
          };
          echo = buildGoModule
            {
              name = "echo";
              src = inputs.echo;
              vendorHash = "sha256-0faUrbv2+fwyk5Z2aj/Nzlnrn25/WmlPLDGx5M3H2xI=";
              meta = with lib; {
                description = "High performance, minimalist Go web framework";
                homepage = "https://github.com/labstack/echo";
                license = licenses.mit;
              };
            };
          pet = buildGoModule
            rec {
              pname = "pet";
              version = "0.3.4";

              src = fetchFromGitHub {
                owner = "knqyf263";
                repo = "pet";
                rev = "v${version}";
                hash = "sha256-Gjw1dRrgM8D3G7v6WIM2+50r4HmTXvx0Xxme2fH9TlQ=";
              };

              vendorHash = "sha256-6hCgv2/8UIRHw1kCe3nLkxF23zE/7t5RDwEjSzX3pBQ=";

              meta = with lib; {
                description = "Simple command-line snippet manager, written in Go";
                homepage = "https://github.com/knqyf263/pet";
                license = licenses.mit;
                maintainers = with maintainers; [ kalbasit ];
              };
            };
        })
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
              };
            }
            { nixpkgs.overlays = overlays; }
            { nix.registry.nixpkgs.flake = nixpkgs; }
          ];
        };
      };
    };
}

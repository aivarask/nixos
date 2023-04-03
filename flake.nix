{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nixpkgs-master.url = "nixpkgs/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
    neotest = {
      url = "github:aivarask/neotest";
      flake = false;
    };
    neotest-playwright = {
      url = "github:aivarask/neotest-playwright";
      flake = false;
    };
    # other
    devshell.url = "github:numtide/devshell";
    LS_COLORS = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
    # VIM
    vim-interestingwords = {
      url = "github:lfv89/vim-interestingwords";
      flake = false;
    };
    nvim-lspconfig.url = "github:neovim/nvim-lspconfig";
    # LSP
    nvim-lsp-file-operations = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };
    neodev-nvim = {
      url = "github:folke/neodev.nvim";
      flake = false;
    };
    typescript-nvim = {
      url = "github:jose-elias-alvarez/typescript.nvim";
      flake = false;
    };
    emmet-ls = {
      url = "github:aca/emmet-ls";
      flake = false;
    };
    # DEBUGGING
    nvim-dap-vscode-js = {
      url = "github:mxsdev/nvim-dap-vscode-js";
      flake = false;
    };
    osv = {
      url = "github:jbyuki/one-small-step-for-vimkind";
      flake = false;
    };
    # TESTING
    neotest-vim-test = {
      url = "github:nvim-neotest/neotest-vim-test";
      flake = false;
    };
    neotest-vitest = {
      url = "github:aivarask/neotest-vitest";
      flake = false;
    };
    neotest-plenary = {
      url = "github:nvim-neotest/neotest-plenary";
      flake = false;
    };
    # OTHER
    session-lens = {
      url = "github:rmagatti/session-lens";
      flake = false;
    };
    pretty-fold = {
      url = "github:anuvyklack/pretty-fold.nvim";
      flake = false;
    };
    nvim-tree-lua = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
  };
  outputs =
    { nixpkgs
    , nixos-hardware
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      home = import ./home.nix;
      overlays = with inputs; [
        rust-overlay.overlays.default
        nur.overlay
        neovim-nightly-overlay.overlay
        statix.overlays.default
        slstatus.overlays.default
        st-flexipatch.overlays.default
        tabbed-flexipatch.overlays.default
        dwm-flexipatch.overlays.default
        dmenu-flexipatch.overlays.default
        nil.overlays.default
        prisma.overlay
        (import ./overlays/py.nix)
        # (import ./overlays/play.nix)
        (_self: _super: { inherit LS_COLORS; })
        # aiva.overlays.default
      ];
    in
    {
      formatter."${system}" = nixpkgs.legacyPackages."${system}".alejandra;

      # PC B450 AORUS M
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hosts/pc.nix
            ./steam.nix
            # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix#L169
            # nixos-hardware.nixosModules.common-cpu-amd

            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = home;
                users.ak = home;
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
            ./hosts/dell.nix
            ./steam.nix
            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = home;
                users.ak = home;
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
            ./hosts/as.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = home;
                users.ak = home;
              };
            }
            { nixpkgs.overlays = overlays; }
            { nix.registry.nixpkgs.flake = nixpkgs; }
          ];
        };
      };
    };
}

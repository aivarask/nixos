{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs-master.url = "nixpkgs/master";
    # nixpkgs-aivarask.url = "github:aivarask/nixpkgs";
    nixpkgs-mguentner.url = "github:mguentner/nixpkgs/playwright_1_30_0";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
    refactoring-nvim = {
      url = "github:ThePrimeagen/refactoring.nvim";
      flake = false;
    };
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
  outputs = {
    nixpkgs,
    # nixpkgs-master,
    nixos-hardware,
    home-manager,
    nixpkgs-mguentner,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    mkPkgs = pkgs: extraOverlays:
      import pkgs {
        inherit system;
        config.allowUnfree = true; # forgive me Stallman senpai
        overlays = extraOverlays;
      };
    # master = mkPkgs nixpkgs-master [];
    mguentner = mkPkgs nixpkgs-mguentner [];
    overlays = with inputs; [
      (final: prev: {
        inherit
          (mguentner)
          playwright
          ;
        inherit mguentner;
      })
      rust-overlay.overlays.default
      nur.overlay
      neovim-nightly-overlay.overlay
      # statix.overlays.default
      slstatus.overlays.default
      st-flexipatch.overlays.default
      tabbed-flexipatch.overlays.default
      dwm-flexipatch.overlays.default
      dmenu-flexipatch.overlays.default
      nil.overlays.default
      prisma.overlay
      (_self: _super: {inherit LS_COLORS;})
      (import ./overlays/python.nix)
    ];
    home = import ./home;
  in {
    formatter."${system}" = nixpkgs.legacyPackages."${system}".alejandra;

    # PC B450 AORUS M
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          ./hosts/pc.nix
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          nixos-hardware.nixosModules.common-hidpi
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.root = import ./home/_pc.nix;
              users.ak = home;
            };
          }
          {nixpkgs.overlays = overlays;}
          {nix.registry.nixpkgs.flake = nixpkgs;}
        ];
      };

      # DELL XPS 7590
      dell = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          ./hosts/dell.nix
          nixos-hardware.nixosModules.dell-xps-15-7590
          nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
          nixos-hardware.nixosModules.common-hidpi
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.root = import ./home/_dell.nix;
              users.ak = home;
            };
          }
          {nixpkgs.overlays = overlays;}
          {nix.registry.nixpkgs.flake = nixpkgs;}
        ];
      };

      as = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
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
          {nixpkgs.overlays = overlays;}
          {nix.registry.nixpkgs.flake = nixpkgs;}
        ];
      };
    };
  };
}

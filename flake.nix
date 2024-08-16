{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR";
    dmenu-flexipatch = { url = "github:bakkeby/dmenu-flexipatch"; flake = false; };
    dwm-flexipatch = { url = "github:bakkeby/dwm-flexipatch"; flake = false; };
    st-flexipatch = { url = "github:bakkeby/st-flexipatch"; flake = false; };
    tabbed-flexipatch = { url = "github:bakkeby/tabbed-flexipatch"; flake = false; };
    musnix = { url = "github:musnix/musnix"; };
    LS_COLORS = { url = "github:trapd00r/LS_COLORS"; flake = false; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-log-highlighting = { url = "github:MTDL9/vim-log-highlighting"; flake = false; };
    vim-interestingwords = { url = "github:lfv89/vim-interestingwords"; flake = false; };
    nvim-lsp-file-operations = { url = "github:antosha417/nvim-lsp-file-operations"; flake = false; };
    lobster.url = "github:justchokingaround/lobster";
    neotest-zig = { url = "github:lawrence-laz/neotest-zig"; flake = false; };
    nvim-dap-vscode-js = { url = "github:mxsdev/nvim-dap-vscode-js"; flake = false; };
    neotest-playwright = { url = "github:thenbe/neotest-playwright"; flake = false; };
    sxhkd-vim = { url = "github:kovetskiy/sxhkd-vim"; flake = false; };
    persistent-breakpoints = { url = "github:Weissle/persistent-breakpoints.nvim"; flake = false; };
    # rustaceanvim = { url = "github:mrcjkb/rustaceanvim"; };
  };
  outputs =
    { nixpkgs, home-manager, nixos-hardware, nix-colors, dmenu-flexipatch, dwm-flexipatch, st-flexipatch, tabbed-flexipatch, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      include = p: with builtins;
        map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
      overlays =
        with inputs; [
          rust-overlay.overlays.default
          nur.overlay
          neovim-nightly-overlay.overlays.default
          (_final: prev: with prev; {
            inherit LS_COLORS;
          })
          (_final: prev:
            let
              inherit (prev.vimUtils) buildVimPlugin;
            in
            {
              vimPlugins = with inputs;
                prev.vimPlugins
                // {
                  vim-log-highlighting = buildVimPlugin {
                    name = "vim-log-highlighting";
                    src = vim-log-highlighting;
                    meta = { homepage = "https://github.com/MTDL9/vim-log-highlighting"; };
                  };
                  vim-interestingwords = buildVimPlugin {
                    name = "vim-interestingwords";
                    src = vim-interestingwords;
                    meta = { homepage = "https://github.com/lfv89/vim-interestingwords"; };
                  };
                  nvim-lsp-file-operations = buildVimPlugin {
                    name = "nvim-lsp-file-operations";
                    src = nvim-lsp-file-operations;
                    meta = { homepage = "https://github.com/antosha417/nvim-lsp-file-operations"; };
                  };
                  neotest-zig = buildVimPlugin {
                    name = "neotest-zig";
                    src = neotest-zig;
                    meta = { homepage = "https://github.com/lawrence-laz/neotest-zig"; };
                  };
                  nvim-dap-vscode-js = buildVimPlugin {
                    name = "nvim-dap-vscode-js";
                    src = nvim-dap-vscode-js;
                    meta = { homepage = "https://github.com/mxsdev/nvim-dap-vscode-js"; };
                  };
                  neotest-playwright = buildVimPlugin {
                    name = "neotest-playwright";
                    src = neotest-playwright;
                    meta = { homepage = "https://github.com/thenbe/neotest-playwright"; };
                  };
                  sxhkd-vim = buildVimPlugin {
                    name = "sxhkd-vim";
                    src = sxhkd-vim;
                    meta = { homepage = "https://github.com/kovetskiy/sxhkd-vim"; };
                  };
                  persistent-breakpoints = buildVimPlugin {
                    name = "persistent-breakpoints";
                    src = persistent-breakpoints;
                    meta = { homepage = "https://github.com/Weissle/persistent-breakpoints.nvim"; };
                  };
                };
            })
        ];
    in
    {

      formatter."${system}" = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          # DELL XPS 7590
          inherit system;
          # specialArgs = nixosModules.args._module.args;
          specialArgs = {
            inherit include;
            inherit dmenu-flexipatch;
            inherit dwm-flexipatch;
            inherit st-flexipatch;
            inherit tabbed-flexipatch;
          };
          modules = [
            # musnix.nixosModules.musnix
            {
              nixpkgs.overlays = overlays;
              nix.registry = {
                nixpkgs.flake = inputs.nixpkgs;
                home-manager.flake = inputs.home-manager;
                nixos = { to = { type = "git"; url = "file:///etc/nixos"; }; };
              };
              environment.systemPackages = [
                # inputs.lobster.packages.${system}.lobster
                # inputs.rustaceanvim.packages.${system}.codelldb
              ];
            }
            ./configuration.nix
            ./_dell.nix
            ./_audio.nix
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = false;
                users.root = import ./home.nix;
              };
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit include;
                inherit nix-colors;
              };
            }
          ];
        };

        pc = nixpkgs.lib.nixosSystem {
          # PC B450 AORUS M
          inherit system;
          specialArgs = {
            inherit include;
            inherit dmenu-flexipatch;
            inherit dwm-flexipatch;
            inherit st-flexipatch;
            inherit tabbed-flexipatch;
          };
          modules = [
            {
              nixpkgs.overlays = overlays;
              nix.registry = {
                nixpkgs.flake = inputs.nixpkgs;
                home-manager.flake = inputs.home-manager;
                nixos = { to = { type = "git"; url = "file:///etc/nixos"; }; };
              };
              environment.systemPackages = [
                # lobster.packages.${system}.lobster
              ];
            }
            ./configuration.nix
            ./_pc.nix
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = false;
                users.root = import ./home.nix;
              };
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit include;
                inherit nix-colors;
              };
            }
          ];
        };
      };
    };
}

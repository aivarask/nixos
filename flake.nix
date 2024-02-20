{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
    neovim-session-manager = { url = "github:Shatur/neovim-session-manager"; flake = false; };
    lobster.url = "github:justchokingaround/lobster";
  };
  outputs =
    { nixpkgs, home-manager, nixos-hardware, nix-colors, lobster, musnix, dmenu-flexipatch, dwm-flexipatch, st-flexipatch, tabbed-flexipatch, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      include = p: with builtins;
        map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
      overlays =
        with inputs; [
          nur.overlay
          neovim-nightly-overlay.overlay

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
                  neovim-session-manager = buildVimPlugin {
                    name = "neovim-session-manager";
                    src = neovim-session-manager;
                    meta = { homepage = "https://github.com/Shatur/neovim-session-manager"; };
                  };
                };
            })
        ];
    in
    {

      devShells."${system}".c = ./shell.nix;
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
              environment.systemPackages = [
                # lobster.packages.${system}.lobster
              ];
              nix.registry = {
                nixpkgs.flake = inputs.nixpkgs;
                home-manager.flake = inputs.home-manager;
                nixos = { to = { type = "git"; url = "file:///etc/nixos"; }; };
              };

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
              home-manager.extraSpecialArgs = { inherit include; inherit nix-colors; };
            }
          ];
        };

        # pc = nixpkgs.lib.nixosSystem {
        #   # PC B450 AORUS M
        #   inherit system;
        #   specialArgs = { inherit inputs; inherit include; };
        #   modules = [
        #     ./configuration.nix
        #     ./_pc.nix
        #     nixos-hardware.nixosModules.common-cpu-amd-pstate
        #     nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
        #     nixos-hardware.nixosModules.common-hidpi
        #     home-manager.nixosModules.home-manager
        #     {
        #       home-manager = {
        #         useGlobalPkgs = true;
        #         useUserPackages = true;
        #         users.root = import ./home.nix;
        #       };
        #       home-manager.extraSpecialArgs = { inherit include; inherit nix-colors; };
        #     }
        #   ];
        # };
      };
    };
}

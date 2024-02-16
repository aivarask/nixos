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
    dwm-flexipatch.url = "github:aivarask/dwm-flexipatch";
    dmenu-flexipatch = { url = "github:bakkeby/dmenu-flexipatch"; flake = false; };
    # st-flexipatch = { url = "github:aivarask/st-flexipatch"; flake = true; };
    tabbed-flexipatch = { url = "github:bakkeby/tabbed-flexipatch"; flake = false; };
    musnix = { url = "github:musnix/musnix"; };
    LS_COLORS = { url = "github:trapd00r/LS_COLORS"; flake = false; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-log-highlighting = { url = "github:MTDL9/vim-log-highlighting"; flake = false; };
    vim-interestingwords = { url = "github:lfv89/vim-interestingwords"; flake = false; };
    nvim-lsp-file-operations = { url = "github:antosha417/nvim-lsp-file-operations"; flake = false; };
    neovim-session-manager = { url = "github:Shatur/neovim-session-manager"; flake = false; };
    nvim-dap-vscode-js = { url = "github:mxsdev/nvim-dap-vscode-js"; flake = false; };
    osv = { url = "github:jbyuki/one-small-step-for-vimkind"; flake = false; };
    lobster.url = "github:justchokingaround/lobster";
  };
  outputs =
    { nixpkgs
    , home-manager
    , nixos-hardware
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      include = p: with builtins;
        map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
      common = { inherit inputs; inherit include; };
    in
    {
      formatter."${system}" = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          # DELL XPS 7590
          inherit system;
          specialArgs = common // { };
          modules = [
            inputs.musnix.nixosModules.musnix
            {
              environment.systemPackages = [
                inputs.lobster.packages.${system}.lobster
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
                useUserPackages = true;
                users.root = import ./home.nix;
              };
              home-manager.extraSpecialArgs = common // { };
            }
          ];
        };

        pc = nixpkgs.lib.nixosSystem {
          # PC B450 AORUS M
          inherit system;
          specialArgs = common // { };
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
                users.root = import ./home.nix;
              };
              home-manager.extraSpecialArgs = common // { };
            }
          ];
        };
      };
    };
}

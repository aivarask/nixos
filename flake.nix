{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR";
    dmenu-flexipatch = { url = "github:bakkeby/dmenu-flexipatch"; flake = false; };
    dwm-flexipatch = { url = "github:bakkeby/dwm-flexipatch"; flake = false; };
    st-flexipatch = { url = "github:bakkeby/st-flexipatch"; flake = false; };
    tabbed-flexipatch = { url = "github:bakkeby/tabbed-flexipatch"; flake = false; };
    LS_COLORS = { url = "github:trapd00r/LS_COLORS"; flake = false; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-log-highlighting = { url = "github:MTDL9/vim-log-highlighting"; flake = false; };
    sxhkd-vim = { url = "github:kovetskiy/sxhkd-vim"; flake = false; };
    vim-interestingwords = { url = "github:lfv89/vim-interestingwords"; flake = false; };
    nvim-lsp-file-operations = { url = "github:antosha417/nvim-lsp-file-operations"; flake = false; };
    neotest-zig = { url = "github:lawrence-laz/neotest-zig"; flake = false; };
    nvim-dap-vscode-js = { url = "github:mxsdev/nvim-dap-vscode-js"; flake = false; };
    neotest-playwright = { url = "github:thenbe/neotest-playwright"; flake = false; };
    persistent-breakpoints = { url = "github:Weissle/persistent-breakpoints.nvim"; flake = false; };
    # rustaceanvim = { url = "github:mrcjkb/rustaceanvim"; };
    musnix = { url = "github:musnix/musnix"; };
  };
  outputs =
    { nixpkgs, home-manager, nixos-hardware, nix-colors, nix-on-droid, LS_COLORS, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      include = p: with builtins;
        map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
      common = {
        imports = [ ]
          ++ include ./config
          ++ include ./config/programs
          ++ include ./config/services
          ++ include ./config/suckless
          ++ include ./config/systemd
        ;
        nixpkgs.overlays =
          with inputs; [
            rust-overlay.overlays.default
            nur.overlay
            (import ./overlays/LS_COLORS.nix LS_COLORS)
            neovim-nightly-overlay.overlays.default
            (import ./overlays/vimPlugins.nix inputs)
            (import ./overlays/suckless.nix inputs)
          ];
        nix.registry = {
          os = { to = { type = "git"; url = "file:///etc/nixos"; }; };
          "dev-templates" = {
            to = {
              owner = "the-nix-way";
              repo = "dev-templates";
              type = "github";
            };
          };
        };
      };
      commonHome = {
        home.stateVersion = "23.05";
        home.enableNixpkgsReleaseCheck = false;
        colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
        imports = [ nix-colors.homeManagerModules.default ]
          ++ include ./home
          ++ include ./home/programs
          ++ include ./home/services
        ;
        home.shellAliases = { };
        home.sessionVariables = {
          BROWSER = "firefox";
          MOZ_X11_EGL = "1";
          # SYSTEM = config.system.name;
        };
        home.file = { };
      };
      commonModules = include ./nixModules ++ [
        inputs.musnix.nixosModules.musnix
      ];
    in
    {
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./nix-on-droid ];
      };
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          # DELL XPS 7590
          inherit system;
          modules = commonModules ++ [
            common
            ./_dell.nix
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = { useGlobalPkgs = true; useUserPackages = true; users.root = commonHome; };
            }
          ];
        };
        pc = nixpkgs.lib.nixosSystem {
          # PC B450 AORUS M
          inherit system;
          modules = commonModules ++ [
            common
            ./_pc.nix
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = { useGlobalPkgs = true; useUserPackages = true; users.root = commonHome; };
            }
          ];
        };
      };
    };
}

# vim: nofoldenable
{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    templates.url = "github:NixOS/templates";
    dev-templates.url = "https://flakehub.com/f/the-nix-way/dev-templates/0.1.283.tar.gz";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    audio.url = "./audio";
    fzf.url = "./fzf";
    git.url = "./_git";
    go.url = "./go";
    lf.url = "./lf";
    lib.url = "./lib";
    LS_COLORS.url = "./LS_COLORS";
    manix.url = "./manix";
    matrix.url = "./matrix";
    suckless.url = "./suckless";
    pistol.url = "./pistol";
    rust.url = "./rust";
    vim.url = "./vim";
    wayland.url = "./wayland";
    zsh.url = "./zsh";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    firefox.url = "./firefox";
    aldale.url = "./containers/aldale";
  };
  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      commonModules = [
        { environment.systemPackages = [ pkgs.git ]; }
        inputs.audio.nixosModules.mpd
        inputs.audio.nixosModules.production
        inputs.audio.nixosModules.pipewire
        inputs.firefox.nixosModules.default
        inputs.fzf.nixosModules.default
        inputs.git.nixosModules.default
        inputs.lf.nixosModules.default
        inputs.lib.nixosModules.default
        inputs.LS_COLORS.nixosModules.default
        inputs.go.nixosModules.default
        inputs.manix.nixosModules.default
        inputs.matrix.nixosModules.default
        inputs.pistol.nixosModules.default
        inputs.rust.nixosModules.default
        inputs.suckless.nixosModules.default
        inputs.vim.nixosModules.default
        inputs.vim.nixosModules.plugins.default
        inputs.zsh.nixosModules.default
        inputs.aldale.nixosModules.default
        {
          imports =
            with inputs.lib.packages."${system}".lib;
            (
              [
                ./containers/mini
                ./lnav
                ./systemd/remote-touchpad.nix
                ./wallpaper
              ]
              ++ i ./config
              ++ i ./network
              ++ i ./programs
              ++ idash ./services
            );
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.root = {
              home.stateVersion = "23.05";
              home.username = "root";
              home.homeDirectory = "/root";
              home.enableNixpkgsReleaseCheck = false;
              manual.json.enable = true;
              colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
              services.mpris-proxy.enable = true; # https://specifications.freedesktop.org/mpris-spec/latest/
              services.blueman-applet.enable = true;
              imports =
                with inputs.lib.packages."${system}".lib;
                [
                  inputs.fzf.nixosModules.home
                  inputs.git.nixosModules.home
                  inputs.lf.nixosModules.home
                  inputs.vim.nixosModules.home
                  inputs.vim.nixosModules.plugins.home
                  inputs.zsh.nixosModules.home
                  inputs.firefox.nixosModules.home
                  inputs.nix-colors.homeManagerModules.default
                  inputs.nix-index-database.hmModules.nix-index
                ]
                ++ i_ ./config
                ++ i_ ./programs
                ++ i_ ./services
                ++ i_ ./lua;
            };
          };
        }
      ];
    in
    {
      checks."${system}".default = pkgs.testers.runNixOSTest {
        name = "self";
        nodes.machine = { ... }: { };
        testScript = builtins.readFile ./flake.test.py;
      };
      devShells."${system}".default = pkgs.mkShell { };
      formatter."${system}" = pkgs.nixfmt-rfc-style;
      nixosConfigurations.dell = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
          ./bluetooth
          ./dell.nix
        ];
        specialArgs = { inherit inputs; };
      };
      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        modules = commonModules ++ [
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          inputs.nixos-hardware.nixosModules.common-hidpi
          ./pc.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}

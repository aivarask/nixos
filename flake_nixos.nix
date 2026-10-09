{ withSystem, inputs, ... }: {
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.foo.overlays.default ];
      config = {
        allowUnfree = true;
      };
    };

    # Now use this configured pkgs in your packages, devShells, etc.
    packages.my-package = pkgs.hello;
  };

  flake.nixosConfigurations.my-machine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # ./configuration.nix
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      ({ config, ... }: {
        # Use the configured pkgs from perSystem
        nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
          { pkgs, ... }: # perSystem module arguments
          pkgs
        );
      })
    ];
  };
}


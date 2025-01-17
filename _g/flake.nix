{
  outputs = _: {
    nixosModules.default = _: {
      imports = [ ./container.nix ];
    };
  };
}

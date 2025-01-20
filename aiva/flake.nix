{
  outputs = _: {
    # runtime! aiva/*.lua
    nixosModules.default = _: {
      imports = [ ./container.nix ];
    };
  };
}

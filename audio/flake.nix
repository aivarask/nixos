{
  inputs = {
  };
  outputs =
    { ... }@inputs:
    {
      nixosModules.mpd = _: { imports = [ ./mpd.nix ]; };
      nixosModules.pipewire = _: { imports = [ ./pipewire.nix ]; };
      nixosModules.pulseaudio = _: { imports = [ ./pulseaudio.nix ]; };
      nixosModules.production =
        ;
    };
}

{ pkgs
, lib
, ...
}: {
  # https://nixos.wiki/wiki/Audio_production
  # https://github.com/musnix/musnix
  musnix.enable = true;
  environment.systemPackages = with pkgs; [
    # https://github.com/NixOS/nixpkgs/blob/d65bceaee0fb1e64363f7871bc43dc1c6ecad99f/pkgs/applications/audio/vital/default.nix#L59
    # https://vital.audio/
    vital
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vital"
      "vital-1.5.5"
    ];
}

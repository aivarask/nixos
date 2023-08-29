{...}: {
  i1 = [./services/music.nix ./services/music.nix];
  i2 = map (n: "${./services}/${n}") (builtins.attrNames (builtins.readDir ./services));
}

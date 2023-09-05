{...}: {
  foo = map (n: "${./config}/${n}") (builtins.attrNames (builtins.readDir ./config));
}

{
  include =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*+\.nix" n)) (attrNames (readDir p)));
}

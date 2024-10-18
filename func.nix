# vim:nofoldenable
{
  include =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*[^_]+\.nix" n)) (attrNames (readDir p)));
  include_ =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*+_+\.nix" n)) (attrNames (readDir p)));
}

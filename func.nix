# vim:nofoldenable
{
  idash =
    p:
    with builtins;
    map (f: "${p}/${f}") (
      filter (n: !isNull (builtins.match "[^.]?[[:alnum:]]+(-|_)?[[:alnum:]]+.nix" n)) (
        attrNames (readDir p)
      )
    );
  i =
    p:
    with builtins;
    map (f: "${p}/${f}") (
      filter (n: !isNull (match "[^.]?[[:alnum:]]+.nix" n)) (attrNames (readDir p))
    );
  i_ =
    p:
    with builtins;
    map (f: "${p}/${f}") (
      filter (n: !isNull (match "[^.]?[[:alnum:]]+_.nix" n)) (attrNames (readDir p))
    );
  include =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*[^_]\.nix" n)) (attrNames (readDir p)));
  include_ =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*+_+\.nix" n)) (attrNames (readDir p)));
}

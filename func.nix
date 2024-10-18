# vim:nofoldenable
rec {
  i =
    p:
    with builtins;
    map (f: "${p}/${f}") (
      filter (n: !isNull (match "[^.]?[[:alnum:]]+.nix" n)) (attrNames (readDir p))
    );
  itest = i ./c;
  itest_programs = i ./config/programs_;
  i_ =
    p:
    with builtins;
    map (f: "${p}/${f}") (
      filter (n: !isNull (match "[^.]?[[:alnum:]]+_.nix" n)) (attrNames (readDir p))
    );
  i_test = i_ ./c;
  include =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*[^_]\.nix" n)) (attrNames (readDir p)));
  include_ =
    p:
    with builtins;
    map (f: "${p}/${f}") (filter (n: !isNull (match "[^.].*+_+\.nix" n)) (attrNames (readDir p)));
}

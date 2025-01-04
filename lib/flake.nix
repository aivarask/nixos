{
  outputs =
    { self, ... }:
    {
      packages."x86_64-linux"."lib" = {
        zzz = "zzz"; # pkgs.lib.zzz
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
      };
      overlays.default = (
        final: prev: {
          lib = prev.lib.extend (final: prev: prev // self.packages."x86_64-linux"."lib");
        }
      );
      nixosModules.default =
        { ... }:
        {
          nixpkgs.overlays = [ self.overlays.default ];
        };
    };
}

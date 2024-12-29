# vim: nofoldenable
{
  description = "matrix";
  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "systems";
  };
  outputs =
    { ... }@inputs:
    let
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs inputs.systems (
          system:
          f {
            pkgs = import inputs.nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cachix
              lorri
              niv
              nixfmt-classic
              statix
              vulnix
              haskellPackages.dhall-nix
            ];
          };
        }
      );
      nixosModules.default =
        # https://wiki.nixos.org/wiki/Matrix
        # https://nixos.org/manual/nixos/stable/#module-services-matrix
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.element-desktop
            pkgs.fractal
          ];
          services.nginx.enable = true;

          # See https://nixos.org/manual/nixos/stable/index.html#module-services-matrix-element-web
          # @aivarask:matrix.org
          # app.element.io
          services.nginx.virtualHosts."localhost" = {
            listen = [
              {
                addr = "[::1]";
                port = 8888;
              }
            ];
            root = pkgs.element-web.override {
              conf = {
                # https://github.com/element-hq/element-web/blob/develop/docs/config.md
                # https://github.com/element-hq/element-web/blob/develop/config.sample.json
                default_theme = "dark";
                room_directory = {
                  servers = [
                    "matrix.org"
                    "nixos.org"
                  ];
                };
              };
            };
          };
        };
    };
}

final: prev:
with prev.lib;
let
  # Load the system config and get the `nixpkgs.overlays` option
  # overlays = (import <nixpkgs/nixos> { }).config.nixpkgs.overlays;
in
# Apply all overlays to the input of the current "main" overlay
# foldl' (flip extends) (_: prev) overlays final
{
  python3Packages = final.python3.pkgs;
  python3 = prev.python3.override {
    # Careful, we're using a different final and prev here!
    packageOverrides = pyfinal: pyprev: {
      mkpl = pyprev.buildPythonPackage rec {
        pname = "mkpl";
        version = "1.27";
        pyproject = true;
        src = pyprev.fetchFromGithub {
          inherit pname version;
          hash = "00gwn42h2fk1ri6psgp6w6lm9clnvhpsrnkvsl6wyy1wqcki17dh";
        };
      };
    };
  };
}

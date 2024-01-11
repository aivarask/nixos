{ pkgs, buildGoModule, fetchFromGitHub, lib, ... }:
let
  pet = buildGoModule
    rec {
      pname = "pet";
      version = "0.3.4";

      src = fetchFromGitHub {
        owner = "knqyf263";
        repo = "pet";
        rev = "v${version}";
        hash = "sha256-Gjw1dRrgM8D3G7v6WIM2+50r4HmTXvx0Xxme2fH9TlQ=";
      };

      vendorHash = "sha256-ciBIR+a1oaYH+H1PcC8cD8ncfJczk1IiJ8iYNM+R6aA=";

      meta = with lib; {
        description = "Simple command-line snippet manager, written in Go";
        homepage = "https://github.com/knqyf263/pet";
        license = licenses.mit;
        maintainers = with maintainers; [ kalbasit ];
      };
    };

in
{
  # https://nixos.wiki/wiki/Go
  # https://nixos.org/manual/nixpkgs/stable/#ssec-language-go
  # environment.pathsToLink = [
  #   ""
  # ];
  environment.sessionVariables = rec {
    GOPATH = "$HOME/go";
    PATH = [
      "${GOPATH}/bin"
    ];
  };
  environment.systemPackages = with pkgs; [
    go
    gopls
    templ
    # pet
  ];
}

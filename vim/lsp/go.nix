{ pkgs, buildGoModule, fetchFromGitHub, lib, ... }:
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
    gow
    echo
    pet
  ];
}

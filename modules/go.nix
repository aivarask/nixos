{ pkgs, ... }:
{
  environment.shellAliases = {
    egp = "echo $GOPATH | tr ':' '\n'";
  };
  environment.sessionVariables = rec {
    GOPATH = "$HOME/go";
    PATH = [
      "${GOPATH}/bin"
    ];
  };
  environment.systemPackages = with pkgs; [
    go
    gotools
    gopls
    templ
    gow
    delve
  ];
}

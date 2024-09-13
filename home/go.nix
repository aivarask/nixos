{ pkgs, ... }:
rec {
  home.shellAliases = {
    egp = "echo $GOPATH | tr ':' '\n'";
  };
  home.sessionVariables = {
    GOPATH = "$HOME/.go";
  };
  home.sessionPath = [
    "${home.sessionVariables.GOPATH}/bin"
  ];
  home.packages = with pkgs; [
    go
    gotools
    gopls
    templ
    gow
    delve
  ];
}

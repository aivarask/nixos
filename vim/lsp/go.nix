{ pkgs, ... }: {

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
  ];
}

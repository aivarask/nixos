{ pkgs, ... }:
let
  gow = pkgs.buildGoModule
    {
      name = "gow";
      src = builtins.fetchGit {
        url = "https://github.com/mitranim/gow";
        rev = "af11a6e1e9ebccdcdace2a6df619355b85494d74";
      };
      vendorHash = "sha256-Xw9V7bYaSfu5kA2505wmef2Ns/Y0RHKbZHUkvCtVNSM=";
    };

  # quote = pkgs.buildGoModule
  #   {
  #     name = "quote";
  #     vendorHash = lib.fakeHash;
  #     src = builtins.fetchGit {
  #       url = "https://github.com/rsc/quote";
  #       ref = "v3.0.0";
  #       rev = "d88915d7e77ed0fd35d0a022a2f244e2202fd8c8";
  #     };
  #   };
in
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
    gopls
    templ
    gow
    # quote
  ];
}

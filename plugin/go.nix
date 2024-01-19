{ pkgs, lib, ... }:
let
  pgx = pkgs.buildGoModule {
    name = "pgx";
    src = builtins.fetchGit {
      url = "https://github.com/jackc/pgx.git";
      # ref = "refs/tags/v5.5.1"; # impure not locked
      rev = "b7de418d46878f65f91c377297d98b8b1a9c406d";
    };
    vendorHash = "sha256-ahGZ7ABG7SDTvObDC//nadIfGEBQrzJlgm5nQlAUPLE=";
  };
  gow = pkgs.buildGoModule
    {
      name = "gow";
      src = builtins.fetchGit {
        url = "https://github.com/mitranim/gow";
        rev = "af11a6e1e9ebccdcdace2a6df619355b85494d74";
        # ref = "";
      };
      vendorHash = "sha256-Xw9V7bYaSfu5kA2505wmef2Ns/Y0RHKbZHUkvCtVNSM=";
    };
  go-sqlite3 = pkgs.buildGoModule {
    name = "go-sqlite3";
    src = builtins.fetchGit {
      url = "https://github.com/mattn/go-sqlite3";
      rev = "bce3773726b3f7ef4609661a0f0f4fb00a0df761";
    };
    CGO_ENABLED = true;
    vendorHash = null;
    # proxyVendor = true;
    buildFlags = "-tags 'linux'";
  };
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
    #
    gow
    # pgx

    # go-sqlite3
  ];
}

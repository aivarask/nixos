{ config, pkgs, lib, ... }: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/databases/mysql.nix
    ensureDatabases = [
      "ak"
      "sand"
    ];
    ensureUsers = [
      {
        name = "ak"; # l
        # https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/services/databases/mysql.nix#L201
        ensurePermissions = {
          "ak.*" = "ALL PRIVILEGES";
          "sand.*" = "ALL PRIVILEGES";
        };
      }
    ];
    initialScript = ./initialScript.sql;
    settings = {
      mysql = {
        auto-rehash = true;
      };
    };
  };
}


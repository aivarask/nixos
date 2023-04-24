{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sqlint
    sqlite
    sqlite-analyzer
    sqlite-interactive
    sqlite-jdbc
    sqlite-utils
    sqlite-web
    sqls
    postgresql
  ];
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/databases/mysql.nix
    ensureUsers = [
      {
        name = "ak"; # l
        # https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/services/databases/mysql.nix#L201
        ensurePermissions = {
          "ak.*" = "ALL PRIVILEGES";
        };
      }
      {
        name = "johndoe"; # l
        ensurePermissions = {
          "mydb.*" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "ak"
      "mydb"
      "mydb_test"
      "mydb_development"
      "mydb_production"
      "mydb_staging"
      "mydb_e2e"
    ];
    initialScript = ./initialScript.sql;
    settings = {
      mysql = {
        auto-rehash = true;
      };
    };
  };
}

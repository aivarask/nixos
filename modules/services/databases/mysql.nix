{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureUsers = [
      {
        name = "ak"; # l
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
      {
        name = "root";
        ensurePermissions = {
          "wpcli.*" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "wpclidemo"
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

{ pkgs, ... }: {
  # ../modules/services/databases/mysql.nix
  environment.systemPackages = with pkgs; [
    sqls
    sqlite-interactive
    sqlite-analyzer
    sqlite-web
  ];
  services.mysql = {
    # https://mynixos.com/nixpkgs/options/services.mysql
    enable = true;
    package = pkgs.mariadb;
    ensureUsers = [
      {
        name = "ak"; # l
        ensurePermissions = {
          "ak.*" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "ak"
    ];
    initialDatabases = [
      { name = "ak"; schema = ./sql_ak.sql; }
    ];
    initialScript = ''
      GRANT ALL ON ak.* to 'ak'@'localhost' IDENTIFIED BY 'l';
      FLUSH PRIVILEGES;
    '';
    settings = {
      mysql = {
        auto-rehash = true;
      };
    };
  };
  services.postgresql = {
    # https://nixos.wiki/wiki/PostgreSQL
    enable = true;
    package = pkgs.postgresql;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE root WITH LOGIN PASSWORD 'root' CREATEDB;
      CREATE DATABASE root;
      GRANT ALL PRIVILEGES ON DATABASE root TO root;
    '';
  };
}


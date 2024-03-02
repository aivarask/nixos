{ pkgs, ... }: {
  # ../modules/services/databases/mysql.nix
  environment.systemPackages = with pkgs; [
    sqlite-interactive
    sqlite-analyzer
    sqlite-web

    sqlfluff # 7k

    sqls # 0.8k
    postgres-lsp # 3.1k
  ];
  networking.firewall.allowedTCPPorts = [
    3306 # mysql
    5434 # postgresql
  ];
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      # /etc/my.cnf
      mysql = {
        auto-rehash = true;
      };
    };
  };
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    ensureDatabases = [ "test" ];
  };
}


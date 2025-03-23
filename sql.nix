{ pkgs, ... }:
{
  # sql
  environment.shellAliases."sqlite" = "sqlite3";
  environment.systemPackages = with pkgs; [
    sqlite-interactive
    sqlite-analyzer
    sqlite-web
    harlequin

    sqlint
    sqlfluff # 7k

    sqls # 0.8k
    postgres-lsp # 3.1k
  ];
  networking.firewall.allowedTCPPorts = [
    3306 # mysql
    5434 # postgresql
  ];
  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
    settings = {
      # /etc/my.cnf
      mysql = {
        auto-rehash = true;
      };
    };
  };
  services.postgresql = {
    enable = false;
    package = pkgs.postgresql;
    ensureDatabases = [ "test" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}

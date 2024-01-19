{ pkgs, ... }: {
  # ../modules/services/databases/mysql.nix
  environment.systemPackages = with pkgs; [
    sqls
    sqlite-interactive
    sqlite-analyzer
    sqlite-web
  ];
  networking.firewall.allowedTCPPorts = [
    3306 # mysql
    5434 # postgresql
  ];
  services.mysql = {
    # https://mynixos.com/nixpkgs/options/services.mysql
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
    # https://nixos.wiki/wiki/PostgreSQL
    enable = true;
    package = pkgs.postgresql;
    ensureDatabases = [ "test" ];
  };
}


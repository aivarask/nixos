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
}

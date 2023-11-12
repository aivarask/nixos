{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # sqlint # failed to build
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

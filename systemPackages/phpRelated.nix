{pkgs, ...}: {
  environment.systemPackages =
    (with pkgs; [php])
    ++ (with pkgs.php80Packages; [composer phpstan psalm])
    ++ (with pkgs.php80Extensions; [xdebug]);
}

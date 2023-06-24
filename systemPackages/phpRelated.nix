{pkgs, ...}: {
  environment.systemPackages =
    (with pkgs; [php])
    ++ (with pkgs.php82Packages; [composer phpstan psalm])
    ++ (with pkgs.php82Extensions; [xdebug]);
}

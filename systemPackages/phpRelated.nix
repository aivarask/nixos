{pkgs, ...}: {
  environment.systemPackages =
    (with pkgs; [php])
    ++ (with pkgs.php82Packages; [
      composer
      # phpstan # failed to validate
      psalm
    ])
    ++ (with pkgs.php82Extensions; [xdebug]);
}

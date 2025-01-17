{ pkgs, ... }:
let
  phpCustom = pkgs.php.buildEnv {
    extensions = (
      { enabled, all }:
      enabled
      ++ (with all; [
        xdebug
      ])
    );
    extraConfig = ''
      xdebug.idekey=neovim
      xdebug.mode=debug
      xdebug.start_with_request=yes
      upload_max_filesize=30M
      post_max_size=31M
      memory_limit = 100M
      max_execution_time = 120
    '';
    # zend_extension=${pkgs.phpExtensions.xdebug.outPath}/lib/php/extensions/xdebug.so
  };
in
{
  environment.systemPackages = [ phpCustom ];
  services.httpd.enablePHP = true;
  services.httpd.phpPackage = phpCustom;
}

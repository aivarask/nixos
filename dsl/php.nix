{ pkgs, ... }: {
  environment.sessionVariables = {
    COMPOSER_ALLOW_SUPERUSER = "1";
    PATH = [
      "$HOME/.config/composer/vendor/bin"
    ];
  };
  environment.shellAliases = {
    wp = "wp --allow-root";
  };
  environment.systemPackages =
    [
      (pkgs.php81.buildEnv {
        extensions = { enabled, all }: enabled ++ (with all; [ xdebug ]);
        # https://www.php.net/manual/en/ini.list.php
        # https://xdebug.org/docs/all_settings#mode
        # https://xdebug.org/docs/all_settings#start_with_request
        extraConfig = ''
          memory_limit = 2G
          cli_server.color = 1
          xdebug.mode = debug
          xdebug.start_with_request = yes 
          zend_extension=${pkgs.php81Extensions.xdebug.outPath}/lib/php/extensions/xdebug.so
        '';
      })
    ]
    ++ (with pkgs; [
      # phpunit
      pest
      phpdocumentor
      wp-cli # phpactor
      symfony-cli
    ])
    ++ (with pkgs.php81Packages; [
      composer
      # box php-codesniffer phpmd phpstan psalm php-cs-fixer phan phive
    ])
    ++ (with pkgs.nodePackages; [
      intelephense
    ])
  ;
}

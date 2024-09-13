{ pkgs, ... }:
{
  home.sessionVariables = {
    COMPOSER_ALLOW_SUPERUSER = "1";
  };
  home.sessionPath = [
    "$HOME/.config/composer/vendor/bin"
  ];
  home.shellAliases = {
    wp = "wp --allow-root";
  };
  home.packages =
    [
      (pkgs.php83.buildEnv {
        extensions = { enabled, all }: enabled ++ (with all; [ xdebug ]);
        extraConfig = builtins.concatStringsSep "\n" [
          "memory_limit = 2G"
          "cli_server.color = 1"
          "xdebug.mode = debug"
          "xdebug.start_with_request = yes"
          # zend_extension=${pkgs.php81Extensions.xdebug.outPath}/lib/php/extensions/xdebug.so
        ];
      })
    ]
    ++ (with pkgs; [
      phpunit
      pest
      phpdocumentor
      wp-cli # phpactor
      symfony-cli
    ])
    ++ (with pkgs.php81Packages; [
      composer
      box
      php-codesniffer
      phpmd
      phpstan
      psalm
      php-cs-fixer
      phan
      phive
    ])
    ++ (with pkgs.nodePackages; [ intelephense ]);
}

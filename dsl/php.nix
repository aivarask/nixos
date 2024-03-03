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
        extraConfig = ''
          memory_limit=2G
          xdebug.mode=debug
          xdebug.start_with_request=yes
        '';
      })
    ]
    ++ (with pkgs; [
      phpunit
      phpdocumentor
      wp-cli # phpactor
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

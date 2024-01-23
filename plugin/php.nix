# https://nixos.wiki/wiki/PHP
# https://search.nixos.org/packages?channel=unstable&type=packages&query=php
# https://xdebug.org/
{ pkgs, ... }: {
  environment.sessionVariables = {
    COMPOSER_ALLOW_SUPERUSER = "1";
  };
  environment.shellAliases = {
    wp = "wp --allow-root";
  };
  environment.systemPackages =
    [
      (pkgs.php83.buildEnv {
        extensions =
          { enabled
          , all
          ,
          }:
          enabled
          ++ (with all; [
            # php83extensions
            xdebug
          ]);
        extraConfig = ''
          memory_limit = 2G
          xdebug.mode = debug
          xdebug.start_with_request = yes
        '';
      })
    ]
    ++ (with pkgs.php83Packages; [
      composer
      box
      # diagnostics
      phpcs
      phpmd
      phpstan
      psalm
      # format
      phpcbf
      php-cs-fixer
      #
      phan # lspconfig
      phive
    ])
    ++ (with pkgs.nodePackages_latest; [
      intelephense
    ])
    ++ (with pkgs; [
      phpactor # lspconfig
      phpunit
      wp-cli
    ]);
}

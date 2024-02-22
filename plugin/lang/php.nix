# https://nixos.wiki/wiki/PHP
# https://xdebug.org/
# https://nixos.org/manual/nixpkgs/unstable/#sec-php
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
          memory_limit = 2G
          xdebug.mode = debug
          xdebug.start_with_request = yes
        '';
      })
    ]
    ++ (with pkgs; [
      phpactor # lspconfig
      phpunit
      wp-cli
    ])
    ++ (with pkgs.php81Packages; [
      composer
      box
      # diagnostics
      phpcs
      phpmd
      phpstan
      psalm # lspconfig
      # format
      phpcbf
      php-cs-fixer
      #
      phan # lspconfig
      phive
    ])
    ++ (with pkgs.nodePackages; [
      intelephense
    ])
  ;
}

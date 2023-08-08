{pkgs, ...}: {
  environment = {
    sessionVariables = {
      PATH = [
        "/etc/nixos/bin"
        "$HOME/.pnpm-global"
        "$HOME/.node_modules/bin"
        "$HOME/.config/composer/vendor/bin"
      ];
      FOO = "environment.sessionVariables";
      # PLAYWRIGHT
      # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
    };
  };
}

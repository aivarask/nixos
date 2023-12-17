{pkgs, ...}: {
  environment = {
    sessionVariables = rec {
      # https://nixos.wiki/wiki/Environment_variables
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
        "/etc/nixos/bin"
        "$HOME/.pnpm-global"
        "$HOME/.node_modules/bin"
        "$HOME/.config/composer/vendor/bin"
      ];

      # FOO = "environment.sessionVariables";
      # PLAYWRIGHT
      # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
    };
  };
}

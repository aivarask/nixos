{pkgs, ...}: {
  environment = {
    sessionVariables = rec {
      # https://nixos.wiki/wiki/Environment_variables
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_BIN_HOME = "$HOME/.local/bin";

      GOPATH = "$HOME/go";
      PATH = [
        "${XDG_BIN_HOME}"
        "${GOPATH}/bin"
        "/etc/nixos/bin"
        "$HOME/.pnpm-global"
        "$HOME/.node_modules/bin"
        "$HOME/.config/composer/vendor/bin"
      ];

      # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
    };
  };
}

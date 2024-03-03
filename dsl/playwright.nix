{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    playwright
  ];
  environment.sessionVariables = {
    # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
  };
}

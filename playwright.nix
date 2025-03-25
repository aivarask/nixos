{ pkgs, ... }:
{
  environment.sessionVariables = {
    # PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = 1;
  };
  environment.systemPackages = [
    # pkgs.playwright
    # pkgs.playwright-driver.browsers
  ];
}

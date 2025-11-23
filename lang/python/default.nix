{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pyright
    black
    isort

    (python3.withPackages (
      ps: with ps; [
        pip
        python-lsp-server
        pylsp-mypy
        mypy
        autopep8
        requests
        pytest
        pytest-watch
        pytest-timeout
        pytest-playwright
        playwright
        pynvim
        livereload
        debugpy
        python-dotenv
        httpie

      ]
    ))
  ];
  environment.sessionVariables.PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
  environment.sessionVariables.PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = 1;
}

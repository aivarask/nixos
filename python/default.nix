{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pyright
    black

    (python3.withPackages (
      ps: with ps; [
        pip
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

        # -S ext:mp3
        # --alias
        yt-dlp
      ]
    ))
  ];
  environment.sessionVariables.PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
  environment.sessionVariables.PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = 1;
}

{
  inputs = { };
  outputs = _: {
    nixosModules.default =
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
              # pytest-playwright
              pynvim
              livereload
              debugpy
              python-dotenv
              httpie
              # playwright
              yt-dlp
            ]
          ))
        ];
      };
  };
}

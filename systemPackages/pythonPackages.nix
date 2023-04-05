{ pkgs, ... }: {
  environment.systemPackages =
    [ pkgs.python3Full ]
    ++ (
      with pkgs.python3Packages; [
        # bcrypt
        # debugpy
        # pdf2image
        # pdftotext
        pip
        pynvim
        # python-lsp-black
        python-lsp-server
        # tomlkit
        flake8
        autopep8
        setuptools
        wheel
        # from overlay
        inotify_simple
        tuimoji
      ]
    );
}

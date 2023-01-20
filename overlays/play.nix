_final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_python-final: python-prev: {
      playwright = python-prev.playwright.overridePythonAttrs (_oldAttrs: {
        pname = "playwright";
        version = "1.30.0";
        src = prev.fetchFromGitHub {
          owner = "microsoft";
          repo = "playwright-python";
          rev = "405de1841bfa8086ab28de14eca6a9ef7c27382d";
          sha256 = "jXXjMoGRPXQzaL3LHca6sqq8NiS5O9txXyf/kMS/mGQ=";
        };
        # src = super.fetchPypi {
        #   inherit pname version;
        #   sha256 =
        #     "24bb8fe1d7ae60ec971668812c0c6c21b2b12d320ff24da59cbb544a6a15a53c";
        # };
        postPatch = ''
          # if setuptools_scm is not listing files via git almost all python files are excluded
          export HOME=$(mktemp -d)
          git init .
          git add -A .
          git config --global user.email "nixpkgs"
          git config --global user.name "nixpkgs"
          git commit -m "workaround setuptools-scm"
          substituteInPlace setup.py \
            --replace "greenlet==2.0.1" "greenlet>=2.0.1" \
            --replace "pyee==9.0.4" "pyee>=9.0.4" \
            --replace "setuptools-scm==7.0.5" "setuptools-scm>=7.0.5" \
            --replace "wheel==0.38.1" "wheel>=0.38.1"
          # Skip trying to download and extract the driver.
          # This is done manually in postInstall instead.
          substituteInPlace setup.py \
            --replace "self._download_and_extract_local_driver(base_wheel_bundles)" ""
          # Set the correct driver path with the help of a patch in patches
        '';
      });
    })
  ];
}

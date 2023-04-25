self: super: rec {
  python3 = super.python3.override {
    packageOverrides = self: super: {
      pyaes = super.buildPythonPackage rec {
        pname = "pyaes";
        version = "1.6.0";
        src = super.fetchPypi {
          inherit pname version;
          hash = "0bp9bjqy1n6ij1zb86wz9lqa1dhla8qr1d7w2kxyn7jbj56sbmcw";
        };
      };
      tuimoji = super.buildPythonPackage rec {
        pname = "tuimoji";
        version = "1.0.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "55f3cde3e153fabffd76a2fca3584b1304470a88888bb6d2c8d6d2f7fbef0e3a";
        };
        propagatedBuildInputs = with self; [urwid];
      };
      openapi-schema-pydantic =
        super.buildPythonPackage
        rec {
          pname = "openapi-schema-pydantic";
          version = "1.2.4";
          src = super.fetchPypi {
            inherit pname version;
            sha256 = "3e22cf58b74a69f752cc7e5f1537f6e44164282db2700cbbcd3bb99ddd065196";
          };
          # doCheck = false;
          propagatedBuildInputs = with python3.pkgs; [
            pydantic
            pytest
          ];
        };
      # sqlalchemy = super.buildPythonPackage rec {
      #   pname = "SQLAlchemy";
      #   version = "2.0.9";
      #   src = super.fetchPypi {
      #     inherit pname version;
      #     sha256 = "95719215e3ec7337b9f57c3c2eda0e6a7619be194a5166c07c1e599f6afc20fa";
      #   };
      #   propagatedBuildInputs = with python3.pkgs; [ typing-extensions greenlet ];
      # };
      langchain =
        super.buildPythonPackage
        rec {
          pname = "langchain";
          version = "0.0.137";
          src = super.fetchPypi {
            inherit pname version;
            sha256 = "d8b7f45490c869d597a37e943fd8437f5414b063253e7e18a4228c51fb075bc5";
          };
          # doCheck = false;
          propagatedBuildInputs = with python3.pkgs;
            [
              requests
              dataclasses-json
              aiohttp
              numpy
              pyyaml
              tenacity
              sqlalchemy
            ]
            ++ [
              self.openapi-schema-pydantic
              # self.sqlalchemy
            ];
        };
    };
  };
  python3Packages = python3.pkgs;
}

# https://ryantm.github.io/nixpkgs/languages-frameworks/python/#python
_self: super:
let
  myOverride = {
    packageOverrides = self: super: {
      inotify_simple = super.buildPythonPackage rec {
        pname = "inotify_simple";
        version = "1.1.7";
        doCheck = false;
        src = super.fetchPypi {
          inherit pname version;
          sha256 = "1jvivp84cyp4x4rsw4g6bzbzqka7gaqhk4k4jqifyxnqqmbdgvcq";
        };
      };
      tuimoji = super.buildPythonPackage rec {
        pname = "tuimoji";
        version = "1.0.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 =
            "55f3cde3e153fabffd76a2fca3584b1304470a88888bb6d2c8d6d2f7fbef0e3a";
          # whl
          # sha256 =
          # "9f46638f6def267efcaae3ddb77f453468c4146aa4cace2b42e02822ae05d49e";
        };
        propagatedBuildInputs = with self; [ urwid ];
      };
      myplay = super.buildPythonPackage rec {
        pname = "myplay";
        version = "1.30.0";
        src = super.fetchPypi {
          inherit pname version;
          sha256 =
            "24bb8fe1d7ae60ec971668812c0c6c21b2b12d320ff24da59cbb544a6a15a53c";
          propagatedBuildInputs = [ super.greenlet super.pyee ];
        };
      };
    };
  };
in
{
  python2 = super.python2.override myOverride;
  python3 = super.python3.override myOverride;
  python310 = super.python310.override myOverride;
}

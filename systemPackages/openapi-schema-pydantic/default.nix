{
  buildPythonPackage,
  fetchPypi,
  pydantic,
}:
buildPythonPackage rec {
  pname = "openapi-schema-pydantic";
  version = "1.2.4";
  src = fetchPypi {
    inherit pname version;
    sha256 = "3e22cf58b74a69f752cc7e5f1537f6e44164282db2700cbbcd3bb99ddd065196";
  };
  doCheck = false;
  propagatedBuildInputs = [
    pydantic
  ];
}

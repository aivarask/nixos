{ buildPythonPackage
, fetchPypi
, requests
, dataclasses-json
, openapi-schema-pydantic
,
}:
buildPythonPackage rec {
  pname = "langchain";
  version = "0.0.137";
  src = fetchPypi {
    inherit pname version;
    sha256 = "d8b7f45490c869d597a37e943fd8437f5414b063253e7e18a4228c51fb075bc5";
  };
  doCheck = false;
  propagatedBuildInputs = [
    requests
    dataclasses-json
    openapi-schema-pydantic
  ];
}

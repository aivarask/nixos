{ pkgs, ... }:
# let
#   my-python-packages = ps:
#     let
#       openapi-schema-pydantic = ps: ps.callPackage ./openapi-schema-pydantic { };
#     in
#     [
#       (openapi-schema-pydantic ps)
#     ];
# in
{
  environment.systemPackages =
    [ pkgs.python3 ]
    ++ (with pkgs.python3Packages; [
      requests
      tuimoji
      autopep8
      # openapi-schema-pydantic
      # langchain
      # (python3.withPackages my-python-packages)
      # (python3.withPackages (ps:
      #   with ps; [
      #     pynvim
      #     # python-lsp-black
      #     python-lsp-server
      #     # tomlkit
      #     flake8
      #     autopep8
      #     setuptools
      #     wheel
      #     # from overlay
      #     inotify_simple
      #     tuimoji
      #     pandas
      #     requests
      #   ]))
    ]);
}

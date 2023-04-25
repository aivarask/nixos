{
  pkgs,
  py-hello,
  ...
}:
pkgs.mkShell {
  buildInputs = with pkgs; [py-hello];
}

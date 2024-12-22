{

  # One or more machines:
  nodes = {
    machine =
      { config, pkgs, ... }:
      {
        # ...
      };
    machine2 =
      { config, pkgs, ... }:
      {
        # ...
      };
    # …
  };

  testScript = ''
    Python code…
  '';
}

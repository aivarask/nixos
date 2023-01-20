_final: prev:
{
  # this key should be the same as the simpleFlake name attribute.
  simple-flake = {
    # assuming that hello is a project-specific package;
    inherit (prev) hello;

    # demonstrating recursive packages
    inherit (prev) terraform-providers;
  };
}

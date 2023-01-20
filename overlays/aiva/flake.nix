# https://nixos.wiki/wiki/Flakes
# https://nixos.wiki/wiki/Overlays
{
  inputs = {
    one-small-step-for-vimkind = {
      url = "github:jbyuki/one-small-step-for-vimkind";
      flake = false;
    };
  };
  outputs = _: {
    # overlays.default = self: super: { };
    overlays = { };
  };
}

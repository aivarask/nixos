{
  hm =
    { pkgs, ... }:
    {
      imports = [ ];
      services.systembus-notify.enable = true;
      home.packages = [ pkgs.conky ];
    };
}

# DOCS:
# https://nixos.wiki/wiki/Awesome
# https://awesomewm.org/apidoc/sample%20files/rc.lua.html
{pkgs, ...}: {
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks # is the package manager for Lua modules
      luadbi-mysql # Database abstraction layer
    ];
  };
}

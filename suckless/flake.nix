# vim: nofoldenable
{
  inputs = {
    dmenu-flexipatch = {
      url = "github:bakkeby/dmenu-flexipatch";
      flake = false;
    };
    dwm-flexipatch = {
      url = "github:bakkeby/dwm-flexipatch";
      flake = false;
    };
    st-flexipatch = {
      url = "github:bakkeby/st-flexipatch";
      flake = false;
    };
  };
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = (
        _: super: with inputs; {
          dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
            src = dmenu-flexipatch;
            configFile = super.writeText "config.h" (builtins.readFile ./dmenu-config.h);
            postPatch = ''
              ${oldAttrs.postPatch}
              cp ${configFile} config.h
            '';
          });
          dwm = super.dwm.overrideAttrs (oldAttrs: rec {
            src = dwm-flexipatch;
            configFile = super.writeText "config.h" (builtins.readFile ./dwm-config.h);
            postPatch = ''
              ${oldAttrs.postPatch}
              cp ${configFile} config.h
            '';
          });
          st = super.st.overrideAttrs (oldAttrs: rec {
            src = st-flexipatch;
            configFile = super.writeText "config.h" (builtins.readFile ./st-config.h);
            postPatch = ''
              ${oldAttrs.postPatch}
              cp ${configFile} config.h
            '';
          });
        }
      );
      nixosModules.default =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ self.overlays.default ];
          environment.systemPackages = with pkgs; [
            dmenu
            dwm
            st
            tabbed
            emojipick
            wmname
            surf
            svkbd
            nsxiv
          ];
        };

    };
}

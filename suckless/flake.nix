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
    tabbed-flexipatch = {
      url = "github:bakkeby/tabbed-flexipatch";
      flake = false;
    };
    sxiv-tabbed = {
      url = "github:bakkeby/sxiv-flexipatch";
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
            patchesFile = super.writeText "patches.h" (builtins.readFile ./dwm-patches.h);
            postPatch = ''
              ${oldAttrs.postPatch}
              cp ${patchesFile} patches.h
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
          tabbed = super.tabbed.overrideAttrs (oldAttrs: rec {
            src = tabbed-flexipatch;
            configFile = super.writeText "config.h" (builtins.readFile ./tabbed-config.h);
            patchesFile = super.writeText "patches.h" (builtins.readFile ./tabbed-patches.h);
            postPatch = ''
              ${oldAttrs.postPatch}
              cp ${patchesFile} patches.h
              cp ${configFile} config.h
            '';
          });
          sxiv = super.sxiv.overrideAttrs (oldAttrs: rec {
            src = sxiv-flexipatch;
            configFile = super.writeText "config.h" (builtins.readFile ./sxiv-config.h);
            patchesFile = super.writeText "patches.h" (builtins.readFile ./sxiv-patches.h);
            postPatch = ''
              ${oldAttrs.postPatch}
              cp ${patchesFile} patches.h
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

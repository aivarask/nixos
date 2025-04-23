{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (
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
        # sxiv = super.sxiv.overrideAttrs (oldAttrs: rec {
        #   src = sxiv-flexipatch;
        #   configFile = super.writeText "config.h" (builtins.readFile ./sxiv-config.h);
        #   patchesFile = super.writeText "patches.h" (builtins.readFile ./sxiv-patches.h);
        #   postPatch = ''
        #     ${oldAttrs.postPatch}
        #     cp ${patchesFile} patches.h
        #     cp ${configFile} config.h
        #   '';
        # });
      }
    )
  ];
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
}

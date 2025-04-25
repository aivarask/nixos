{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (
      final: prev: with inputs; {
        dmenu = prev.dmenu.overrideAttrs (old: rec {
          src = dmenu-flexipatch;
          configFile = prev.writeText "config.h" (builtins.readFile ./dmenu-config.h);
          postPatch = ''
            ${old.postPatch}
            cp ${configFile} config.h
          '';
        });
        dwm = prev.dwm.overrideAttrs (old: rec {
          src = dwm-flexipatch;
          configFile = prev.writeText "config.h" (builtins.readFile ./dwm-config.h);
          patchesFile = prev.writeText "patches.h" (builtins.readFile ./dwm-patches.h);
          postPatch = ''
            ${old.postPatch}
            cp ${patchesFile} patches.h
            cp ${configFile} config.h
          '';
        });
        st = prev.st.overrideAttrs (old: rec {
          src = st-flexipatch;
          configFile = prev.writeText "config.h" (builtins.readFile ./st-config.h);
          postPatch = ''
            ${old.postPatch}
            cp ${configFile} config.h
          '';
        });
        tabbed = prev.tabbed.overrideAttrs (old: rec {
          src = tabbed-flexipatch;
          configFile = prev.writeText "config.h" (builtins.readFile ./tabbed-config.h);
          patchesFile = prev.writeText "patches.h" (builtins.readFile ./tabbed-patches.h);
          postPatch = ''
            ${old.postPatch}
            cp ${patchesFile} patches.h
            cp ${configFile} config.h
          '';
        });
      }
    )
  ];
  environment.sessionVariables.CPATH = with pkgs; [
    # "${pkgs.xorg.libXrender.dev}/include"
    # "${pkgs.xorg.libX11.dev}/include"
    # "${pkgs.xorg.xorgproto}/include"
    # "${pkgs.xorg.libXft.dev}/include"
    # "${pkgs.freetype.dev}/include"
    # "${pkgs.fontconfig.dev}/include"
  ];
  environment.systemPackages = with pkgs; [
    dmenu
    #
    fontconfig
    xorg.libX11
    xorg.libXinerama
    zlib
    xorg.libXft
    #
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

{ pkgs, dmenu-flexipatch, dwm-flexipatch, st-flexipatch, tabbed-flexipatch, ... }: {
  environment.systemPackages = with pkgs; [ dmenu dwm st tabbed wmname emojipick surf ];
  nixpkgs.overlays = [
    (_self: super: {
      dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
        src = dmenu-flexipatch; # https://github.com/bakkeby/dmenu-flexipatch
        configFile = super.writeText "config.h" (builtins.readFile ./dmenu-config.h);
        postPatch = ''
          ${oldAttrs.postPatch}
          cp ${configFile} config.h 
          # echo "#define FUZZYMATCH_PATCH 0" > patches.h
        '';
      });

      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        src = dwm-flexipatch; # https://github.com/bakkeby/dwm-flexipatch
        #define MODKEY Mod4Mask
        configFile = super.writeText "config.h" (builtins.readFile ./dwm-config.h);
        postPatch = ''
          ${oldAttrs.postPatch}
          cp ${configFile} config.h
        '';
      });

      st = super.st.overrideAttrs (oldAttrs: rec {
        src = st-flexipatch; # https://github.com/bakkeby/st-flexipatch
        configFile = super.writeText "config.h" (builtins.readFile ./st-config.h);
        postPatch = ''
          ${oldAttrs.postPatch}
          cp ${configFile} config.h 
        '';
        # patches = [
        #   ./st-gruvbox.diff
        #   ./st-font.diff # st -z 32 -e ...
        # ];
      });

      # tabbed = super.tabbed.overrideAttrs
      #   (oldAttrs: rec {
      #     src = tabbed-flexipatch; # https://github.com/bakkeby/tabbed-flexipatch
      #     # disable focusurgent
      #     configFile = super.writeText "config.h" (builtins.readFile ./tabbed-config.h);
      #     postPatch = ''
      #       ${oldAttrs.postPatch}
      #       cp ${configFile} config.h 
      #     '';

      #   });
    })
  ];

}

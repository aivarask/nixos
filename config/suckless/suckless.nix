{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    dmenu
    dwm
    st
    tabbed
    # --
    wmname
    emojipick
  ];

  environment.shellAliases = {
    # st = "st -z 32";
  };

  nixpkgs.overlays = [
    # inputs.dwm-flexipatch.overlays.default
    (self: super: {
      dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/misc/dmenu/default.nix
        src = inputs.dmenu-flexipatch; # https://github.com/bakkeby/dmenu-flexipatch
        configFile = super.writeText "config.h" (builtins.readFile ./dmenu-config.h); # defaults
        postPatch = ''
          ${oldAttrs.postPatch}
          cp ${configFile} config.h 
          # echo "#define FUZZYMATCH_PATCH 0" > patches.h
        '';
      });

      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/window-managers/dwm/default.nix
        src = inputs.dwm-flexipatch; # https://github.com/bakkeby/dwm-flexipatch
        configFile = super.writeText "config.h" (builtins.readFile ./dwm-config.h); #define MODKEY Mod4Mask
        postPatch = ''
          ${oldAttrs.postPatch}
          cp ${configFile} config.h
        '';
      });

      st = super.st.overrideAttrs (oldAttrs: rec {
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/terminal-emulators/st/default.nix
        src = inputs.st-flexipatch; # https://github.com/bakkeby/st-flexipatch
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

      tabbed = super.tabbed.overrideAttrs
        (oldAttrs: rec {
          # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/window-managers/tabbed/default.nix
          src = inputs.tabbed-flexipatch; # https://github.com/bakkeby/tabbed-flexipatch
          configFile = super.writeText "config.h" (builtins.readFile ./tabbed-config.h); # disable focusurgent
          postPatch = ''
            ${oldAttrs.postPatch}
            cp ${configFile} config.h 
          '';

        });
    })
  ];

}

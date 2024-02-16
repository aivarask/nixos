{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    dmenu
    st
    tabbed
    # --
    dwm
    wmname
    emojipick
  ];

  environment.shellAliases = {
    st = "st -z 32";
  };

  nixpkgs.overlays = [
    inputs.dwm-flexipatch.overlays.default
    (self: super: {
      dmenu = super.dmenu.overrideAttrs (oldAttrs: {
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/misc/dmenu/default.nix
        src = inputs.dmenu-flexipatch; # https://github.com/bakkeby/dmenu-flexipatch
        configFile = super.writeText "config.h" (builtins.readFile ./dmenu-config.h);
      });

      st = super.st.overrideAttrs (oldAttrs: rec {
        # https://st.suckless.org/patches/
        patches = [
          ./st-gruvbox.diff
          ./st-font.diff # st -z 32 -e ...
        ];
        # configFile = super.writeText "config.h" (builtins.readFile ./st-config.h);
        # postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h\n";
      });

      tabbed = super.tabbed.overrideAttrs (oldAttrs: rec {
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

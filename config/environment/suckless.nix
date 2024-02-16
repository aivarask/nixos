{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    tabbed
    dwm
    wmname
    st
    dmenu
    emojipick
  ];

  environment.shellAliases = {
    st = "st -z 32";
  };
  nixpkgs.overlays = [
    # inputs.tabbed-flexipatch.overlays.default
    inputs.dwm-flexipatch.overlays.default
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        # https://st.suckless.org/patches/
        patches = [
          ./st-gruvbox.diff
          ./st-font.diff # st -z 32 -e ...
        ];
        # configFile = super.writeText "config.h" (builtins.readFile ./st-config.h);
        # postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h\n";
      });
      dmenu = super.dmenu.overrideAttrs (oldAttrs: {
        src = inputs.dmenu-flexipatch;
      });
      tabbed = super.tabbed.overrideAttrs (oldAttrs: {
        src = inputs.tabbed-flexipatch;
        configFile = super.writeText "config.h" (builtins.readFile ./tabbed-config.h);
      });
    })
  ];

}

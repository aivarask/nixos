{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    tabbed
    dmenu
    st
    dwm
    emojipick
    wmname
  ];

  nixpkgs.overlays = [

    inputs.tabbed-flexipatch.overlays.default
    inputs.dwm-flexipatch.overlays.default
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        # https://st.suckless.org/patches/
        patches = [
          # ./st-fontsize.diff
          # ./st-delkey-20201112-4ef0cbd.diff
          # st -z 32 -e ...
        ];
        configFile = super.writeText "config.h" (builtins.readFile ./st-config.h);
        postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h\n";
      });
    })
  ];

}

inputs: (self: super: with inputs;{
  dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
    src = dmenu-flexipatch;
    configFile = super.writeText "config.h" (builtins.readFile ../config/suckless/dmenu-config.h);
    postPatch = ''
      ${oldAttrs.postPatch}
      cp ${configFile} config.h 
    '';
  });
  dwm = super.dwm.overrideAttrs
    (oldAttrs: rec {
      src = dwm-flexipatch;
      configFile = super.writeText "config.h" (builtins.readFile ../config/suckless/dwm-config.h);
      postPatch = ''
        ${oldAttrs.postPatch}
        cp ${configFile} config.h
      '';
    });
  st = super.st.overrideAttrs
    (oldAttrs: rec {
      src = st-flexipatch;
      configFile = super.writeText "config.h" (builtins.readFile ../config/suckless/st-config.h);
      postPatch = ''
        ${oldAttrs.postPatch}
        cp ${configFile} config.h 
      '';
    });
})

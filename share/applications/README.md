for p in $(echo $XDG_DATA_DIRS | tr ':' '\n'); do echo $p; ls $p/applications 2> /dev/null; done | fzf


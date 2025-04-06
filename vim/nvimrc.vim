  let &packpath.=',/etc/nixos'
  let &runtimepath.=',/etc/nixos'
  runtime! lua/cfg/**/*{.lua,.vim}
  runtime! lua/_*{.lua,.vim}
  set scrolloff=18
  set cmdheight=1


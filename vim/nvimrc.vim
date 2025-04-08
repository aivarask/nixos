let &packpath.=',/etc/nixos'
let &runtimepath.=',/etc/nixos'
runtime! lua/cfg/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}


{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    neotest
    neotest-go
    neotest-phpunit
    neotest-plenary
    neotest-rust
    neotest-zig
  ];
}

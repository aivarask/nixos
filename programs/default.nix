{ ... }:
{
  programs.npm = {
    enable = true;
    npmrc = ''
      		prefix = ''${HOME}/.npm
      		color=true
      							'';
  };
  programs.screen = {
    enable = true;
    screenrc = '''';
  };
}

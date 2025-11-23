{ pkgs, lib, ... }:
{
  console.useXkbConfig = true;
  # console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v32.psf.gz";
  # console.keyMap = lib.mkForce "us";
  # console.keyMap = "${pkgs.kbd}/share/keymaps/i386/qwerty/lt.map.gz";
  location.provider = lib.mkDefault "manual";
  location.latitude = 54.0;
  location.longitude = 25.0;
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kalesnykas.aivaras@gmail.com";
  security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.nginx.setEnvironment = false;
  time.timeZone = "Europe/Vilnius";
  users.defaultUserShell = pkgs.zsh;
  users.users."root" = {
    shell = pkgs.zsh;
    extraGroups = [ "http" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEs8Ir7meX21p/xxIfwz/Z9vYDF0VCE29t4pML7iF/X root@dell"
      # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANknZM5gmvqk6PlxOsiiPtmGEOH6HCIGs/YSarBXfEW root@pc"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINCfPZBHEBgGHptxSr6E4DvnztZQ8+MXvui0Bz9LJJM3 root@pc"
    ];
  };
}

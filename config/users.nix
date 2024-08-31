{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
  };
  users.users."root" = {
    shell = pkgs.zsh;
    extraGroups = [ "http" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQChD+UD2rzKfPKCdWgZqEoJWKfqXi3NZ/7umM9Dhfy3i9G+LW4reoPrvFVCnCx+kWGwpJyA5BGQ5ZnOiRQxWDDvBCZO3MkLZVWF3UkWld9YrnT1LWaZkSPu3jeMstI42ppASPLQUoqdeFy06+NYlhjOW1uQ2voAW7+ExgHkraxP7f8/VIk7FVR2hhrO5+xA+YqQWfhZfAfBMdDoZ3/Vo7cCr1llNCoMwBkMd9VW4Sq8G7e8rl1tBHZuxDAlVEBbeio+G8Wb+zuqluktHElW/VRGLycmv+L63WiAjRwJetiSpwty9gLwcVHuV+rEBUUZnF5Nk/419uJ6ZSVmYLKrnYlOKnF62fL3kcN/TT9I+FA9akurgnqFcUF24P0zeuu/0jiF4vHlm2HqjsB8E0R/nigkLzREzBW3VTfDxpMMKQqKCcWwIZEPygwLBfRFSxUVX9dnXQ+Cwz86mJJZUAiceFGgYVz6PYZSJLrkrZpc6SQhjoc79aigtQQlt+Z3UWNZGDAbk8Zz2guOeACdRDJd7X++G3MYAFgqC9jl4Or5fFeDFAyhYMEV+hkFG+nbjnjPCXrXP1w6BOMNi3qNcMWNAypfBp6Mi9/g8OcF+cNTRj4kuaPvpZQEoFs9jqwIm1P+IIzRrgSAcdSpNSC9JBwmyv8coBfzBqCv+qEUk7rXuTjGiQ== root@dell
"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpPySWSpNtMX1EGwpa9rAzNq3/WydMS8dJcwZfNgsjujizfQrWDqFysWIfcnHtyd/42ylRQb6spcjitjyy0P9eITid6Mt5LvC/4BQ5uBUDn7rynebuHCJ5K0h9zkZVxhA/TjpiYdbSXpLPdarlGD6MnviUKGAu32iR1wx5EXLRGUHt1uB41ohi9S/UTzUc2HnOrjth8jcN4iaoE95Ak9j8+Z6+09u5kvaHIgBTRzQN0yA/nDtVJCEp535OiQ7qmIiQO1dXpBT72njXuNFbaOSrK4zBcofmn9srJN3KibTCseE4sDO4jy7FNwLHWMTpiHsZ0TUpMYmgoebsbjCtl0Ft8+mENs3KdAd2IsbaubHHvTq/KV4dmsLf9X0ucZS2YqF2Bz4MH5jzEvNSQMYuXXJdbqNRldP2ia0G0IuhI/Ovsd4UqdRHq41D0vu4CRlzAmIuXFf9eBii512Ujieye9bAmwYlqZR9b17jFKd9mN7FaoC0k1DFiXHZSKzqxSm+C20= root@pc"
    ];
  };
  users.users.ak = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "pulse" "video" "disk" "networkmanager" ];
  };
}

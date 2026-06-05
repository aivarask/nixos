{ ... }:
{
  home-manager.sharedModules = [
    (
      { inputs, ... }:
      {
        imports = [

          inputs.nirinit.nixosModules.nirinit
        ];
        services.nirinit = {
          enable = true;
          settings.skip.apps = [ "steam" ];
          settings.launch."chromium-example.com__-Default" = "example-web-app";

        };

      }
    )
  ];

}

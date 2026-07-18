{ ... }: {
  home-manager.sharedModules = [

    {
      home.username = "root";
      home.homeDirectory = "/root";
    }
  ];
}

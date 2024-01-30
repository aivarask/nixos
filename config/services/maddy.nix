{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Maddy
  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "ab@localhost"
      "test@test.ekolangas.lt"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "ab@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "test@test.ekolangas.lt".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
    # openFirewall = true;
    # tls = {
    #   loader = "acme";
    #   extraConfig = ''
    #     email test@test.ekolangas.lt
    #     agreed # indicate your agreement with Let's Encrypt ToS
    #     # host ${config.services.maddy.primaryDomain}
    #     challenge dns-01
    #     dns gandi {
    #       api_token "{env:GANDI_API_KEY}"
    #     }
    #   '';
    # };
    # config =
    #   builtins.replaceStrings [
    #     "imap tcp://0.0.0.0:143"
    #     "submission tcp://0.0.0.0:587"
    #   ] [
    #     "imap tls://0.0.0.0:993 tcp://0.0.0.0:143"
    #     "submission tls://0.0.0.0:465 tcp://0.0.0.0:587"
    #   ]
    #   options.services.maddy.config.default;
    # secrets = [
    #   "${pkgs.writeText "secrets" ''
    #     GANDI_API_KEY=1234
    #   ''}"
    # ];
  };
  networking.firewall.allowedTCPPorts = [ 993 465 ];
  # https://nixos.wiki/wiki/Maddy#Autoconfig
  # services.go-autoconfig = {
  #   enable = true;
  #   settings = {
  #     service_addr = ":1323";
  #     domain = "autoconfig.example.org";
  #     imap = {
  #       server = "example.org";
  #       port = 993;
  #     };
  #     smtp = {
  #       server = "example.org";
  #       port = 587;
  #     };
  #   };
  # };
}

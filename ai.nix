{pkgs,...}:{
  environment.systemPackages = with pkgs; [
    openclaw];

    permittedInsecurePackages = [
      "openclaw-2026.4.21"
    ];
  }

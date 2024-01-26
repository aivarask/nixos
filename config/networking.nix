_: {
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    useNetworkd = true;
    hosts = {
      "192.168.1.1" = [ "hw.local" ];
      # --
      "127.0.0.1" = [
        "live.fixasparts.com"
        "example.com"
        # "binarycache.example.com"
      ];
      "192.168.1.190" = [ "pcl" "pcl.local" ];
      "192.168.1.195" = [ "pcw" "pcw.local" ];
      "192.168.1.180" = [ "dell" "dell.local" ];
      "192.168.1.170" = [ "i7" "i7.local" ];
      "192.168.1.150" = [ "a5" "a5.local" ];
      "188.69.243.169" = [ "namai" "namai.local" ];
      "195.181.244.248" = [ "q0nr.l.dedikuoti.lt" "fixas" "new.fixasparts.com" ];
    };
    extraHosts = ''
      127.0.0.2 other-localhost
      10.0.0.1 server
      127.0.0.1 live.fixasparts.com
    '';
  };
}

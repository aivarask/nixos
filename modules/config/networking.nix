_: {
  networking.hosts = {
    "192.168.1.1" = ["hw.local"];
    # --
    "127.0.0.1" = ["live.fixasparts.com"];
    "192.168.1.190" = ["pcl"];
    "192.168.1.195" = ["pcw"];
    "192.168.1.180" = ["dell"];
    "188.69.243.169" = ["namai.local"];
    "195.181.244.248" = ["q0nr.l.dedikuoti.lt" "fixas" "new.fixasparts.com"];
  };
  networking.extraHosts = ''
    127.0.0.2 other-localhost
    10.0.0.1 server
    127.0.0.1 live.fixasparts.com
  '';
}

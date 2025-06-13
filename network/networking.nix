{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ookla-speedtest
    curlFull
    httpie
    tcpdump
    tcpflow
    lftp
    ethtool
    wol
    bind
    drill
    dig
    dnsx
    geoipWithDatabase
    mkcert
    nmap
    wget
    whois
    inetutils
    openssl
    nss
    socat
    websocat
    websocketd
  ];
  # netstat -antup
  # nestat --all --numeric --tcp --udp --program
  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
    "192.168.1.1"
  ];
  programs.bandwhich.enable = true;
  programs.iftop.enable = true;
  programs.sharing.enable = true;
  programs.mtr.enable = true;
  programs.wireshark.enable = true;
  # https://nixos.wiki/wiki/Systemd-networkd
  # systemd.network.enable = true;
  # services.resolved.enable = true;
  # networking.useNetworkd = true;
  # networking.resolvconf.useLocalResolver = true;

  # networking.firewall.enable = true;
  #  networking.firewall.extraCommands = ''
  #   ip6tables --table nat --flush OUTPUT
  #   ${lib.flip (lib.concatMapStringsSep "\n")
  #     [
  #       "udp"
  #       "tcp"
  #     ]
  #     (proto: ''
  #       ip6tables --table nat --append OUTPUT \
  #         --protocol ${proto} --destination ::1 --destination-port 53 \
  #         --jump REDIRECT --to-ports 51
  #     '')
  #   }
  # '';
}

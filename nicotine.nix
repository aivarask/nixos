{ config, ... }: {
  xdg.configFile."nicotine/config".text = ''
    [server]
    server = ('server.slsknet.org', 2242)
    login = aivarask
    passw = mandela12
    interface = 
    ctcpmsgs = False
    autosearch = []
    autoreply = 
    portrange = (2234, 2239)
    upnp = True
    upnp_interval = 4
    auto_connect_startup = True
    userlist = []
    banlist = []
    ignorelist = []
    ipignorelist = {}
    ipblocklist = {}
    autojoin = ['nicotine']
    autoaway = 15
    away = False
    private_chatrooms = False
    command_aliases = {}

    [transfers]
    incompletedir = /etc/nixos/music/.incomplete
    downloaddir = /etc/nixos/music
    uploaddir = /etc/nixos/music/.received
    usernamesubfolders = False
    shared = [('music', '/etc/nixos/music')]

  '';
}

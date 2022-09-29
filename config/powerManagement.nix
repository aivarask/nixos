{ config, ... }: {
  powerManagement.resumeCommands = ''
    echo "This should show up in the journal after resuming.";
    systemctl restart cron.service;
  '';
}

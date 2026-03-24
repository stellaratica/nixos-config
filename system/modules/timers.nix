{lib, ...}: {
  systemd = {
    services = {
      shutdown = {
        enable = lib.mkDefault true;
        description = "Shuts down at 03:00 on Sundays because it's healthy";
        startAt = "Sun 03:00";
        serviceConfig = {
          ExecStart = "systemctl poweroff";
        };
      };
    };
    timers = {
      hibernate = {
        enable = lib.mkDefault true;
        description = "Hibernates at 03:00 for most of the week so the computer isn't on all night";
        wantedBy = ["timers.target"];
        timerConfig = {
          OnCalendar = "Mon..Sat 03:00";
          Unit = "systemd-hibernate.service";
        };
      };
    };
  };
}

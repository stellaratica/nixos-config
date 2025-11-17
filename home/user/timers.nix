{...}: {
  systemd.user.timers = {
    hibernate = {
      Unit = {description = "Hibernates at 03:00 for most of the week so the computer isn't on all night";};
      Timer = {
        OnCalendar = "Mon..Sat 03:00:00";
        Unit = "systemd-hibernate.service";
      };
      Install = {wantedBy = ["timers.target"];};
    };
    reboot = {
      Unit = {description = "Reboots at 03:00 on Sundays because it's healthy";};
      Timer = {
        OnCalendar = "Sun 03:00:00";
        Unit = "systemd-reboot.service";
      };
      Install = {wantedBy = ["timers.target"];};
    };
  };
}

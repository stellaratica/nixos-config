{
  systemd.user = {
    services = {
      battery-level = {
        Unit = {
          Description = "Battery Level Checker";
          After = ["graphical.target"];
        };

        Service = {
          ExecStart = "%h/.config/waybar/scripts/battery-level.sh";
          Type = "oneshot";
        };
      };
    };

    timers = {
      battery-level = {
        Unit = {
          Description = "Run Battery Level Checker";
        };

        Timer = {
          OnBootSec = "1min";
          OnUnitActiveSec = "1min";
          Unit = "battery-level.service";
        };

        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };
}

{...}: {
  systemd.user.timers = {
    hibernate = {
      description = "Hibernates at 03:00 for most of the week so the computer isn't on all night";
      wants = "hibernate.target";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "Mon..Sat 03:00:00";
        Unit = "hibernate.target";
      };
    };
  };
}

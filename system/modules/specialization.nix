{
  specialisation = {
    no-power-timers.configuration = {
      systemd = {
        services.shutdown.enable = false;
        timers.hibernate.enable = false;
      };
    };
  };
}

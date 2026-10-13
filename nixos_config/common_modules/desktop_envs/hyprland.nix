{ inputs, pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # Launch via UWSM so graphical-session.target starts (xdg-desktop-portal,
  # dms and hypridle depend on it; without the portal apps miss dark mode)
  programs.hyprland.withUWSM = true;
  services.displayManager.defaultSession = "hyprland-uwsm";
  services.hypridle.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    wofi # program starter
    hyprshot # screen shot tool
    libnotify # notify-send, used by hypr scripts (DMS is the notification daemon)
    hyprsunset # Nightlight
    hyprpolkitagent # Polkit auth
    hyprpicker # pick colors from screean
    wl-screenrec # screen rec
    slurp # select region
    kdePackages.kdeconnect-kde
    mpvpaper
    hyprpaper
  ];

  # Firewall needed for kde connect
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

}

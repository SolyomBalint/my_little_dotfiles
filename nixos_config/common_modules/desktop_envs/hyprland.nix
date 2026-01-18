{ inputs, pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;
  services.hypridle.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    wofi # program starter
    font-awesome # Needed by waybar
    hyprshot # screen shot tool
    swaynotificationcenter # notification daemon /swaync
    libnotify # needed by swaync, should be part of gnome, but making sure
    hyprsunset # Nightlight
    hyprpolkitagent # Polkit auth
    hyprpicker # pick colors from screean
    wl-screenrec # screen rec
    slurp # select region
    kdePackages.kdeconnect-kde
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

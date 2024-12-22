{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;
  programs.hyprland.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    wofi # program starter
    waybar # Status bar config in: ~/.config/waybar
    font-awesome # Needed by waybar
    hyprshot # screen shot tool
    swaynotificationcenter # notification daemon /swaync
    libnotify # needed by swaync, should be part of gnome, but making sure
    hyprlock # Lock screen config in: ~/.config/hypr/hyprlock.conf
    hypridle # Add idle mode config in: ~/.config/hypr/hyprlock.conf
    hyprpaper # Adding backgrounds
    hyprsunset # Nightlight
  ];

}

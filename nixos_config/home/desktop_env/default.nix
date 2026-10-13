{
  config,
  pkgs,
  nixpkgs_stable,
  inputs,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
  ];
  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal) (doesn't buildrn)
    enableClipboardPaste = true;
  };

  # IBus (pulled in by GNOME) autostarts in every non-GNOME/KDE session that
  # runs XDG autostart (UWSM does) and nags that it should be launched by the
  # compositor. Keyboard layouts come from xkb, so hide it outside GNOME.
  xdg.configFile."autostart/ibus-daemon.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=IBus
    Hidden=true
  '';

}

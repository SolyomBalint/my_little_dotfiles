{ pkgs, ... }:

{
  # Machine-level gaming stack. None of these options have a per-user form:
  # steam ships udev rules and firewall holes, gamescope needs a setcap
  # wrapper, and gamemode runs a privileged daemon. Access is gated per user
  # through group membership (see mkUser in flake.nix) and through which home
  # modules a user imports.
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    libdrm
  ];
}

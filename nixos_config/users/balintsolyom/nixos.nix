{
  username,
  pkgs,
  inputs,
  nixpkgs_stable,
  ...
}:

{
  # Nixos global configuration for the current user.
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    libdrm
    mangohud
  ];

  programs.gamemode.enable = true;

  # For zen
  # services.flatpak.enable = true;

  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];
}

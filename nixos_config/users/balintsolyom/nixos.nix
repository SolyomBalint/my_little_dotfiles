{
  username,
  pkgs,
  inputs,
  ...
}:

{
  # Nixos global configuration for the current user.
  programs.gamescope.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs.gamemode.enable = true;

  # For zen
  services.flatpak.enable = true;

  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];
}

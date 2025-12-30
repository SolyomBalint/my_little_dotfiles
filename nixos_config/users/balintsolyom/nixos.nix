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
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    libdrm
    mangohud
  ];

  programs.gamemode.enable = true;

  virtualisation.docker.enable = true;

  services.samba = {
    package = pkgs.samba4Full;
    usershares.enable = true;
    enable = true;
    openFirewall = true;
  };

  # To be discoverable with windows
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # Make sure your user is in the samba group
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "samba"
      "docker"
    ];
  };

}

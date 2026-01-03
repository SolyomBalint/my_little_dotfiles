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

  # For zen
  # services.flatpak.enable = true;

  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];
  # # 1. Ensure the share directories exist with correct permissions
  # systemd.tmpfiles.rules = [
  #   "d /mnt/Shares/Public  0775 ${username} users - -"
  #   "d /mnt/Shares/Private 0770 ${username} users - -"
  # ];

  # services.samba = {
  #   enable = true;
  #   openFirewall = true;
  #
  #   settings = {
  #     global = {
  #       "interfaces" = "lo enp8s0f3u1u4";
  #       "bind interfaces only" = "yes";
  #       "workgroup" = "WORKGROUP";
  #       "server string" = "smbnix";
  #       "netbios name" = "smbnix";
  #       "security" = "user";
  #       "guest account" = "nobody";
  #       "map to guest" = "bad user";
  #     };
  #
  #     "public" = {
  #       "path" = "/mnt/Shares/Public";
  #       "browseable" = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "${username}";
  #       "force group" = "users";
  #     };
  #
  #     "private" = {
  #       "path" = "/mnt/Shares/Private";
  #       "browseable" = "yes";
  #       "read only" = "no";
  #       "guest ok" = "no";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "${username}";
  #       "force group" = "users";
  #     };
  #   };
  # };
  #
  # # 2. Windows Service Discovery (Network Neighborhood)
  # services.samba-wsdd = {
  #   enable = true;
  #   openFirewall = true;
  # };
  #
  # # 3. Apple/Linux Service Discovery (mDNS)
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true; # Allow this machine to resolve .local names
  #   publish = {
  #     enable = true;
  #     userServices = true;
  #   };
  #   openFirewall = true;
  # };
}

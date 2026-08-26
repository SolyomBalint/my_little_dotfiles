{ pkgs, ... }:

{
  # Machine-level daemons and sharing. These are system services with no
  # per-user form; docker is gated by the "docker" group instead.
  virtualisation.docker.enable = true;

  # MTP share
  services.gvfs.enable = true;

  # quick local fileshare
  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;

  # Local LLM runner. RX 6700S is Navi 23 (gfx1032), not officially in ROCm's
  # supported list, so spoof it as gfx1030 via HSA_OVERRIDE_GFX_VERSION=10.3.0.
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "10.3.0";
    loadModels = [
      "mistral:7b"
      "deepseek-r1:7b"
    ];
  };

  # NFS mounts for synology
  boot.supportedFilesystems = [
    "nfs"
    "ntfs"
  ];
  services.rpcbind.enable = true; # needed for NFS

  # fileSystems."/mnt/synology" = {
  #   device = "192.168.0.213:/volume1/Public";
  #   fsType = "nfs";
  #   options = [
  #     "nfsvers=3"
  #     "proto=tcp"
  #     "_netdev"
  #     "nofail"
  #     "x-systemd.automount"
  #     "noauto"
  #     "x-systemd.idle-timeout=600"
  #   ];
  # };

  # # 1. Ensure the share directories exist with correct permissions
  # systemd.tmpfiles.rules = [
  #   "d /mnt/Shares/Public  0775 balintsolyom users - -"
  #   "d /mnt/Shares/Private 0770 balintsolyom users - -"
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
  #       "force user" = "balintsolyom";
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
  #       "force user" = "balintsolyom";
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

  # # 3. Apple/Linux Service Discovery (mDNS) for both samba and nfs
  services.avahi = {
    enable = true;
    nssmdns4 = true; # Allow this machine to resolve .local names
    openFirewall = true;
  };
}

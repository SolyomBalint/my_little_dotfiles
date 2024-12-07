{
  pkgs,
  lib,
  username,
  ...
}:
{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nix.settings.trusted-users = [ username ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weakly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
  };

  services.printing.enable = true;

  programs.firefox.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    gcc
    unzip
    zip
    gnutar
    ripgrep
    xclip
  ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}

{
  config,
  pkgs,
  inputs,
  ...
}:
{

  home.packages = with pkgs; [
    fastfetch
    stow
    fd
    inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default
    bat
    delta
    fzf
    bottom
    jq
    dos2unix
    nmap
    gnome-multi-writer
    nettools
    bear

    # Music handling
    playerctl

    # For sensors
    # pciutils
    # gtop # similiar to bottom
    # amdgpu_top

    # Useful nix CLI tools
    nix-output-monitor

    firejail
    rpi-imager
    android-tools
    # filebot

    #AI
    opencode

    poppler-utils

    python313Packages.markitdown
  ];
}

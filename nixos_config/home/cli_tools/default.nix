{
  config,
  pkgs,
  inputs,
  ...
}:
{

  home.packages = with pkgs; [
    neofetch
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

    # PDF viewers
    zathura
    evince

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
    claude-code
    poppler-utils
  ];
}

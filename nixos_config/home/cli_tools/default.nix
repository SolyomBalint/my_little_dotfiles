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
    inputs.yazi.packages.${pkgs.system}.default
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

    # ePUB viewers
    # TODO Broken right now
    # calibre

    # Music handling
    playerctl

    # For sensors
    # pciutils
    # gtop # similiar to bottom
    # amdgpu_top

    # Useful nix CLI tools
    nix-output-monitor

    firejail
    android-tools

    #AI
    claude-monitor
    claude-code
  ];
}

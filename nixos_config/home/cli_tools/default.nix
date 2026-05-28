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
    pciutils
    amdgpu_top

    #AI
    opencode

    poppler-utils

    python313Packages.markitdown
  ];
}

{
  inputs,
  pkgs,
  config,
  nixpkgs_stable,
  ...
}:
{
  home.packages = with pkgs; [
    signal-desktop
    prismlauncher
    mangohud
    discord
    wineWow64Packages.waylandFull
    vlc
    # wonderdraft
    nixpkgs_stable.bottles
    gimp
    # inkscape
    # krita
  ];
}

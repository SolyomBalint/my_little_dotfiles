{
  inputs,
  pkgs,
  config,
  nixpkgs_stable,
  ...
}:
{
  home.packages = with pkgs; [
    brave
    signal-desktop
    prismlauncher
    discord
    spotify
    wineWow64Packages.waylandFull
    firefox
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
    # wonderdraft
    nixpkgs_stable.bottles
    gimp
    # inkscape
    # krita
  ];
}

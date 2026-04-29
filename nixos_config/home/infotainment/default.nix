{
  inputs,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    httrack
    brave
    signal-desktop
    prismlauncher
    discord
    spotify
    wineWow64Packages.waylandFull
    firefox
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
    # lutris
    wonderdraft
    gimp
    # inkscape
    # krita
  ];
}

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
    # signal-desktop
    obsidian
    prismlauncher
    discord
    spotify
    wineWowPackages.waylandFull
    firefox
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
    blender-hip # hardware accelerated
    lutris
  ];
}

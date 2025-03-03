{
  inputs,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    signal-desktop
    obsidian
    prismlauncher
    discord
    spotify
    unstable_pkgs.wineWow64Packages.waylandFull
    unstable_pkgs.lutris
  ];
}

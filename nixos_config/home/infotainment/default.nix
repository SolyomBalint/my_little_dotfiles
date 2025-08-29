{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    signal-desktop
    obsidian
    prismlauncher
    discord
    spotify
    wineWowPackages.waylandFull
    firefox
    inputs.zen-browser.packages."${system}".twilight
  ];
}

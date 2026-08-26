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
    spotify
    firefox
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
    foliate
  ];
}

{
  config,
  pkgs,
  nixpkgs_stable,
  inputs,
  ...
}:
{

  home.packages = with pkgs; [
    godot
    unityhub
  ];
}

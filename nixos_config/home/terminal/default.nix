{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    tmux
    zsh
    oh-my-posh
  ];
}

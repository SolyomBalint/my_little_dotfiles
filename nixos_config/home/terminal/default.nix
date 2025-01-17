{ inputs, pkgs, unstable_pkgs, ... }:
{
  home.packages = with pkgs; [
    # kitty
    tmux
    zsh
    oh-my-posh
    inputs.ghostty.packages.x86_64-linux.default
    unstable_pkgs.wezterm
  ];
}

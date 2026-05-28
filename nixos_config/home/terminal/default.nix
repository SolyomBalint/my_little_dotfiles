{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    tmux
    zsh
    oh-my-posh
    ghostty
    wezterm
  ];
}

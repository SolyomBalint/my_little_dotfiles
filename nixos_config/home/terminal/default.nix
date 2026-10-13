{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    tmux
    oh-my-posh
    ghostty
    wezterm
  ];
}

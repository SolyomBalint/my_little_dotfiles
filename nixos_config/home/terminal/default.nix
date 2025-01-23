{
  inputs,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # kitty
    tmux
    zsh
    oh-my-posh
    unstable_pkgs.ghostty
    unstable_pkgs.wezterm
  ];
}

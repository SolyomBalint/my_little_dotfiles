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
    unstable_pkgs.zsh
    unstable_pkgs.oh-my-posh
    unstable_pkgs.ghostty
    unstable_pkgs.wezterm
  ];
}

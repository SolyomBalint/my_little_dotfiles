# Users home manager configuration
{ pkgs, inputs, ... }:
{
  # Import home manager modules here
  imports = [
    ../../home/core.nix

    ../../home/cli_tools
    ../../home/coding
    ../../home/terminal
    ../../home/neovim
    ../../home/infotainment
    ../../home/game_dev
    ../../home/desktop_env
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "SolyomBalint";
        email = "balint.solyom01@gmail.com";
      };
    };
  };
}

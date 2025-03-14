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
  ];

  programs.git = {
    enable = true;
    userName = "SolyomBalint";
    userEmail = "balint.solyom01@gmail.com";
  };
}

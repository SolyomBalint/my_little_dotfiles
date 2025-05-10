{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    neovim

    # Formatters
    stylua
    black
    isort
    shfmt
    nixfmt-rfc-style
    nodePackages_latest.prettier

    # LSPs
    lua-language-server
    llvmPackages_latest.clang-tools
    neocmakelsp
    pyright
    marksman
    nixd
    typescript-language-server
    glsl_analyzer

    # Diagnostic tools
    mypy

    # Debuggers
    gdb
    python312Packages.debugpy

    # Tree sitter
    gcc

    # Avante needs this
    gnumake
    nodejs_24
  ];

  # Needed for nix lsp
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}

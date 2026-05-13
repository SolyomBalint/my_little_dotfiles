{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    neovim
    tree-sitter

    # Formatters
    stylua
    black
    isort
    shfmt
    nixfmt
    prettierd
    typstyle

    # LSPs
    lua-language-server
    # llvmPackages_latest.clang-tools
    neocmakelsp
    pyright
    marksman
    nixd
    typescript-language-server
    glsl_analyzer
    tinymist

    # Diagnostic tools
    mypy

    # Debuggers
    gdb
    python313Packages.debugpy

    gcc15

    claude-agent-acp

    gnumake
    # nodejs_24

    # document generation
    typst
    texliveFull
  ];

  # Needed for nix lsp
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}

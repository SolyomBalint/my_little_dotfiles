{
  config,
  pkgs,
  inputs,
  nixpkgs_stable,
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
    wgsl-analyzer
    # llvmPackages_latest.clang-tools
    nixpkgs_stable.neocmakelsp
    pyright
    marksman
    nixd
    typescript-language-server
    glsl_analyzer
    tinymist
    arduino-language-server

    # Diagnostic tools
    mypy

    # Debuggers
    gdb
    python313Packages.debugpy

    gcc15

    claude-agent-acp

    gnumake
    nodejs

    # document generation
    typst
    texliveFull
    texlab
    arduino-cli
  ];

  # Needed for nix lsp
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}

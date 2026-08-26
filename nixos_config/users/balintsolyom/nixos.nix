{ ... }:

{
  # System-level configuration that is specific to this user. Machine-wide
  # programs and services (steam, docker, ollama, sharing) live in
  # hosts/zephyrus/ because NixOS has no per-user form for them; user-facing
  # packages belong in ./home.nix, and group membership in flake.nix's mkUser.
}

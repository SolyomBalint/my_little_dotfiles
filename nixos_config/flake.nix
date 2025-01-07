{
  description = "Global Entry Flake";

  inputs = {
    # Base package repository
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # unstable
    unstable_pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Extra Hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Adding home mamanger 24.11 release
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";

      # Adding inheritance relation to avoid conflicts in for different nix packages
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      unstable_pkgs,
      ...
    }:
    {
      nixosConfigurations = {
        balintnixos =
          let
            username = "balintsolyom";
          in
          nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit username;
              inherit inputs;
              inherit system;
              unstable_pkgs = import unstable_pkgs {
                system = system;
                config.allowUnfree = true;
              };
            };
            modules = [
              ./hosts/zephyrus
              ./users/${username}/nixos.nix

              # Make home manager a NixOs module so it will always load
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };
      };
    };
}

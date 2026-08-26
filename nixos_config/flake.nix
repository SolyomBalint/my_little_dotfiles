{
  description = "Global Entry Flake";

  inputs = {
    # Base package repository
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixpkgs_stable = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager";

      # Adding inheritance relation to avoid conflicts in for different nix packages
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";

    ## Quickshell based desktop env
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixpkgs_stable,
      ...
    }:
    let
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        nixpkgs_stable = import nixpkgs_stable {
          inherit system;
          config.allowUnfree = true;
          overlays = [
          ];
        };
      };

      # A user is three things: a system account, a system-level module of
      # their own, and a home-manager configuration.
      mkUser =
        {
          username,
          uid,
          extraGroups ? [ ],
        }:
        {
          imports = [ ./users/${username}/nixos.nix ];

          users.users.${username} = {
            inherit uid;
            isNormalUser = true;
            description = username;
            extraGroups = [
              "networkmanager"
              "wheel"
              "video"
              "render"
            ]
            ++ extraGroups;
          };

          home-manager.users.${username} = import ./users/${username}/home.nix;
        };
    in
    {
      nixosConfigurations = {
        balintnixos = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;

          modules = [
            ./hosts/zephyrus

            # Make home manager a NixOs module so it will always load
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
            }

            (mkUser {
              username = "balintsolyom";
              uid = 1000;
              extraGroups = [ "docker" ];
            })
            (mkUser {
              username = "holodetect";
              uid = 1001;
              extraGroups = [ "docker" ];
            })
          ];
        };
      };
    };
}

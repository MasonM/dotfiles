{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable }:
  let
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit (prev) system;
        config.allowUnfree = true;
      };
    };

    mkNixosConfiguration = { system, conf }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          conf
        ];
      };
  in {
    nixosConfigurations.nixos = mkNixosConfiguration {
      system = "x86_64-linux";
      conf = ./hosts/desktop/configuration.nix;
    };
  };
}


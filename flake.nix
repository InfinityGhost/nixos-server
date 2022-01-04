{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    overlays = {
      nixpkgs.overlays = inputs.nixpkgs.lib.lists.flatten [
        (import ./overlays)
        (import ./pkgs)
      ];
    };

  in {
    nixosConfigurations.nixos-server = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        overlays
        ./modules
        ./configuration.nix
      ];
      specialArgs = {
        inherit inputs;
      };
    };
  };
}

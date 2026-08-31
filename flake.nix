{
  description = "Meine NixOS Flake Konfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Oder Ihre Version, z.B. "github:nixos/nixpkgs/nixos-24.11"
  };

  outputs = { self, nixpkgs ,... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Falls Sie eine andere Architektur nutzen, hier anpassen
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
	  ./jupyter.nix
	  ./packages.nix
        ];
      };
    };
  };
}

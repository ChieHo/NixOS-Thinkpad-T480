{
  description = "Meine NixOS Flake Konfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Oder Ihre Version, z.B. "github:nixos/nixpkgs/nixos-24.11"
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager ,... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Falls Sie eine andere Architektur nutzen, hier anpassen
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
	  ./jupyter.nix
	  ./packages.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;	  
	    home-manager.useUserPackages = true;	   
	    home-manager.users.chieho = import ./home.nix;
	  }
        ];
      };
    };
  };
}

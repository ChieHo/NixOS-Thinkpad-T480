{
  description = "Meine NixOS Flake Konfiguration";

  inputs = {
   
    #unstable nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; 
    
    #home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    #nur-community
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = { self, nixpkgs, home-manager , nur,... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; 
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
	  ./jupyter.nix
	  home-manager.nixosModules.home-manager
	  {
            nixpkgs.overlays = [ nur.overlays.default ];
	    home-manager.useGlobalPkgs = true;	  
	    home-manager.useUserPackages = true;	   
	    home-manager.users.chieho = import ./home.nix;
	  }
        ];
      };
    };
  };
}

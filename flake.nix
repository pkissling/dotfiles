{
  description = "pkissling's macOS setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    { nix-darwin, home-manager, nix-homebrew, ... }:
    let
      host =
        profile:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit profile; };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            ./nix/darwin.nix
            ./nix/${profile}.nix
          ];
        };
    in
    {
      darwinConfigurations = {
        private = host "private";
        work = host "work";
      };
    };
}

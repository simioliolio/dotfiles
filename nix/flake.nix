{
  description = "Simon's macOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    args = {
      username = "shaycock";
    };
  in
  {
    # Set Git commit hash for darwin-version.
    # TODO: Move to ./modules/darwin, and handle 'self'
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Tonto
    darwinConfigurations."Tonto" = nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = with args; [
        ./modules/darwin
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
# Apple Silicon Only
              enableRosetta = true;
# User owning the Homebrew prefix
              user = username;
            };
          }
      home-manager.darwinModules.home-manager
      {

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username} = { pkgs, ...}: {
            home.username = username;
            home.stateVersion = "24.05";
            programs.home-manager.enable = true;
            imports = [
              ./modules/fzf
              ./modules/git
              ./modules/kitty
              ./modules/neovim
              ./modules/zsh
            ];
          };
        };
      }
      ];
    };

    # Needed?
    # darwinPackages = self.darwinConfigurations."Tonto".pkgs;
  };

}

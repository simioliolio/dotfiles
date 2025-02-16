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
    username = "shaycock";

    configuration = { pkgs, lib, config, ... }: {

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
	pkgs.mkalias
        pkgs.neovim
        (pkgs.vscode-with-extensions.override {
          vscodeExtensions = with pkgs.vscode-extensions; [
            bbenoist.nix
          ];
        })
      ];

      users.users.${username} = {
        name = username;
        home = /Users/${username};
      };

      # Homebrew casks
      homebrew = {
        brews = [
	  "git"
	];
        enable = true;
	casks = [
	  "google-chrome"
	  "kitty"
	  "slack"
	];
	onActivation.cleanup = "zap";
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Set unfree exceptions
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"
	"slack"
	"vscode"
	"vscode-with-extensions"
      ];

      # Ensure GUI apps are searchable in spotlight
      # https://gist.github.com/elliottminns/211ef645ebd484eb9a5228570bb60ec3
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
  	};
      in
  	pkgs.lib.mkForce ''
  	# Set up applications.
  	echo "setting up /Applications..." >&2
  	rm -rf /Applications/Nix\ Apps
  	mkdir -p /Applications/Nix\ Apps
  	find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  	while read -r src; do
    	  app_name=$(basename "$src")
    	  echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
  	done
      '';

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Tonto
    darwinConfigurations."Tonto" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
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
	      # home.packages = [ pkgs.kitty ];
	      home.username = username;
	      home.stateVersion = "24.05";
	      programs.home-manager.enable = true;
              imports = [
	        ./modules/kitty
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

{ pkgs, lib, config, username, ... }:
{

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.mkalias
      pkgs.neovim
      (pkgs.vscode-with-extensions.override {
         vscodeExtensions = with pkgs.vscode-extensions; [
           bbenoist.nix
           eamodio.gitlens
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
      "bazelisk"
      "git"
      "git-lfs"
      "ripgrep"
      "tree"
    ];
    enable = true;
    casks = [
      "docker"
      "google-chrome"
      "kitty"
      "slack"
    ];
    onActivation.cleanup = "zap";
  };

# Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

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
}


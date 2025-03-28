{ pkgs, lib, config, username, ... }:
{

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.kitty
    pkgs.mkalias
    pkgs.neovim
    (pkgs.vscode-with-extensions.override {
       vscodeExtensions = with pkgs.vscode-extensions; [
         bazelbuild.vscode-bazel
         bbenoist.nix
         eamodio.gitlens
         ms-python.python
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
      "cmake"
      "gh"
      "git"
      "git-lfs"
      "hermit"
      "mas"
      "mvn"
      "ninja"
      "nvm"
      "pyenv"
      "python-lsp-server"
      "shellcheck"
      "ripgrep"
      "tree"
      "uv"
    ];
    enable = true;
#    casks = [
#      "docker"
#      "google-chrome"
#      "google-cloud-sdk"
#      "grid"
#      "kitty"
#      "slack"
#      "tuple"
#    ];
#    masApps = {
#      "Be Focused Pro - Pomodoro Timer" = 961632517;
#    };
    onActivation.cleanup = "zap";
  };

# Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog
system = {
  stateVersion = 6;
  defaults = {
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 10;
    };
    trackpad.TrackpadThreeFingerDrag = true;
    trackpad.Clicking = true;
    universalaccess.closeViewScrollWheelToggle = true;
    universalaccess.reduceMotion = true;
  };
};

# The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

# Allow unfree apps (ie, vscode, etc)
  nixpkgs.config.allowUnfree = true;

# TODO: Ensure GUI apps are searchable in spotlight
# https://gist.github.com/elliottminns/211ef645ebd484eb9a5228570bb60ec3

}


{ pkgs, lib, config, username, ... }:
{

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.google-cloud-sdk
    pkgs.kitty
    pkgs.mkalias
    pkgs.neovim
    pkgs.pure-prompt
    (pkgs.vscode-with-extensions.override {
       vscodeExtensions = with pkgs.vscode-extensions; [
         bazelbuild.vscode-bazel
         bbenoist.nix
         eamodio.gitlens
         llvm-vs-code-extensions.vscode-clangd
         ms-python.python
         ms-vsliveshare.vsliveshare
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
      "busted"
      "cmake"
      "gh"
      "git"
      "git-lfs"
      "hermit"
      "jenv"
      "ktlint"
      "kotlin-language-server"
      "lua-language-server"
      "luacheck"
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
      "yamllint"
    ];
    enable = true;
    casks = [
      "cursor"
      "ghostty"
      "google-chrome"
      "grid"
      "meld"
      "slack"
      "tuple"
    ];
    masApps = {
      # TODO: Fix mas
      # "Be Focused Pro - Pomodoro Timer" = 961632517;
    };
    onActivation.cleanup = "zap";
  };

# Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog

  system = {
    stateVersion = 6;
    defaults = {
      CustomUserPreferences = {
        "com.google.Chrome" = {
          "NSUserKeyEquivalents" = {
            "Move Tab to New Window" = "^~@t";
          };
        };
      };
      dock = {
        autohide = true;
      };
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 10;
        "com.apple.trackpad.forceClick" = false;
        AppleKeyboardUIMode = 3;
      };
      trackpad.Clicking = true;
      trackpad.TrackpadThreeFingerDrag = true;
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


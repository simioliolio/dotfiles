# dotfiles 

A just-another-dotfiles-repo which quickly became a nix config.

## Install

```bash
# Install commandline tools
xcode-select --install
# Install nix
sh <(curl --proto '=https' --tlsv1.2 -L x https://nixos.org/nix/install)
# Clone this repo
mkdir ~/src
cd ~/src
git clone git@github.com:simioliolio/dotfiles.git
# Bootstrap nix darwin
cd ~/src/dotfiles/nix
nix build .#darwinConfigurations.Tonto.system
.result/sw/bin/darwin-rebuild switch --flake .#Tonto
# Optionally remove the `result` simlink as it will no longer be needed
rm result
```

### Note about `git`

`git` installation is managed with homebrew but [the git config file](https://github.com/simioliolio/dotfiles/tree/main/nix/modules/git/config) is not managed by nix. This is because sometimes there are scripts which want to modify the git config but cannot. As a post-first-time-install step, copy the contents of the checked-in git config to ~/.config/git/config.

## Update

```
darwin-rebuild switch --flake <path-to-repo>/nix#Tonto
```

## Note

- Make sure Kitty is granted full disk access, otherwise it wont be possible to modify user permissions, etc.

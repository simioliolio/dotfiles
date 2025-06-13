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

## Update

```
darwin-rebuild switch --flake <path-to-repo>/nix#Tonto
```

## Note

- Make sure Kitty is granted full disk access, otherwise it wont be possible to modify user permissions, etc.

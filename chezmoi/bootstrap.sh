#!/usr/bin/env bash
# First-time machine setup. After this, use `chezmoi apply` to sync.
set -e

echo "🚀 Starting dotfiles bootstrap process..."

# 1. Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# 2. Install Homebrew if it isn't installed
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Ensure brew is in PATH for the rest of the script (handles both Apple Silicon & Intel Macs)
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
else
  echo "🍺 Homebrew is already installed."
fi

# 3. Install Chezmoi
if ! command -v chezmoi &> /dev/null; then
  echo "🏠 Installing Chezmoi..."
  brew install chezmoi
fi

# 4. Initialize and apply dotfiles (also triggers run_onchange scripts for brew bundle, mise, etc.)
echo "📥 Cloning and applying dotfiles via Chezmoi..."
chezmoi init --apply simioliolio/dotfiles

echo "✅ Bootstrap complete! Please restart your terminal (or your Mac) to ensure all changes take effect."
echo "   From now on, run 'chezmoi apply' to sync your machine."

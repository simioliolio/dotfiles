#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
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
echo "🏠 Installing Chezmoi..."
brew install chezmoi

# 4. Initialize and apply Chezmoi dotfiles
# This clones your repo to ~/.local/share/chezmoi and applies your configurations
echo "📥 Cloning and applying dotfiles via Chezmoi..."
chezmoi init --apply simioliolio/dotfiles

# 5. Install Homebrew packages from the Brewfile
# This assumes you placed your Brewfile in the root of your dotfiles repo
echo "📦 Installing tools and apps from Brewfile..."
brew bundle --file="$HOME/.local/share/chezmoi/homebrew/Brewfile"

# 6. Install language runtimes via Mise
# Now that Homebrew has installed Mise (based on your Brewfile), we can run it
if command -v mise &> /dev/null; then
  echo "🛠️ Installing language runtimes via Mise..."
  mise install
else
  echo "⚠️ Mise not found. Make sure 'brew \"mise\"' is in your Brewfile!"
fi

echo "✅ Bootstrap complete! Please restart your terminal (or your Mac) to ensure all changes take effect."

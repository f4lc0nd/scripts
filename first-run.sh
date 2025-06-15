#!/bin/bash

set -e  # Exit on error
set -u  # Treat unset variables as errors

echo "🛠️  Starting system setup..."

# ----------- Flatpak Setup ------------
echo "📦 Installing Flatpak applications..."

# Ensure Flatpak and Flathub are available
sudo pacman -S --noconfirm flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak apps
flatpak install -y flathub com.mattjakeman.ExtensionManager        # Extension Manager
flatpak install -y flathub org.telegram.desktop                     # Telegram
flatpak install -y flathub com.discordapp.Discord                   # Discord
flatpak install -y flathub com.spotify.Client                       # Spotify
flatpak install -y flathub io.missioncenter.MissionCenter          # Advanced Task Manager
flatpak install -y flathub com.github.unrud.VideoDownloader        # YouTube Downloader

# ----------- Pacman Packages ------------
echo "📦 Installing Pacman applications..."
sudo pacman -S --noconfirm brave obs-studio vlc wget zsh curl git

# ----------- Warp Terminal ------------
echo "⚡ Installing Warp Terminal..."

WARP_URL="https://releases.warp.dev/stable/v0.2025.06.11.08.11.stable_01/warp-terminal-v0.2025.06.11.08.11.stable_01-1-x86_64.pkg.tar.zst"
WARP_PKG="${WARP_URL##*/}"

wget -c "$WARP_URL"
sudo pacman -U --noconfirm "$WARP_PKG"
rm "$WARP_PKG"  # Clean up

# ----------- Zsh, Oh My Zsh, and Plugins ------------
echo "🎨 Customizing Zsh shell environment..."

# Install AUR helper (paru) if not present
if ! command -v paru &> /dev/null; then
  echo "🔧 paru not found. Please install paru first and re-run this script."
  exit 1
fi

# Install Zsh and plugins
paru -S --noconfirm ocs-url nvm  google-chrome zsh-autosuggestions zsh-syntax-highlighting zsh-completions

# Install Oh My Zsh
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Update .zshrc
echo '
# Load NVM
[[ -s /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

# Load plugins
[[ -s /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -s /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
' >> ~/.zshrc

# Change default shell to Zsh
echo "🐚 Setting Zsh as the default shell..."
chsh -s "$(which zsh)"

echo "✅ Setup complete! Please restart your terminal or log out and log back in to apply changes."

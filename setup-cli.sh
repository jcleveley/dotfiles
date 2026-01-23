#!/bin/bash
# ============================================================================
# CLI Setup Script - Install required tools
# ============================================================================

echo "🚀 Setting up your lean CLI environment..."
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew already installed"
fi

# Install packages
echo ""
echo "📦 Installing CLI tools..."
brew install tmux zsh bat eza starship neovim zoxide

echo ""
echo "🔤 Installing JetBrains Mono Nerd Font..."
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

echo ""
echo "🖥️  Installing iTerm2..."
brew install --cask iterm2

echo ""
echo "✨ Installing Catppuccin theme for bat..."
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

echo ""
echo "📦 Installing Antidote (zsh plugin manager)..."
brew install antidote

echo ""
echo "📦 Installing TPM (tmux plugin manager)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo ""
echo "✅ All tools installed!"
echo ""
echo "📝 Next steps:"
echo "1. Clone your dotfiles from GitHub (or copy configs):"
echo "   ~/.zshrc, ~/.tmux.conf, ~/.config/starship.toml, ~/.config/nvim/init.lua"
echo ""
echo "2. Configure iTerm2:"
echo "   - Preferences → Profiles → Text"
echo "   - Set Font to: JetBrainsMono Nerd Font Mono (14pt)"
echo "   - Preferences → Profiles → Colors"
echo "   - Import: https://github.com/catppuccin/iterm/blob/main/colors/catppuccin-mocha.itermcolors"
echo ""
echo "3. Restart terminal: exec zsh"
echo ""
echo "4. In tmux, press Ctrl-Space + I to install plugins"
echo ""
echo "5. Open nvim - plugins will auto-install"
echo ""

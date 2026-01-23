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
echo "🔗 Creating symlinks to dotfiles..."

# Get the dotfiles directory (assumes script is run from dotfiles folder)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Backup existing files
backup_and_link() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "  Backing up existing $target to ${target}.backup"
        mv "$target" "${target}.backup"
    elif [ -L "$target" ]; then
        echo "  Removing existing symlink $target"
        rm "$target"
    fi

    echo "  Linking $target → $source"
    ln -s "$source" "$target"
}

# Create symlinks
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config"
backup_and_link "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

echo ""
echo "✅ Symlinks created!"
echo ""
echo "📝 Next steps:"
echo "1. Configure iTerm2:"
echo "   - Preferences → Profiles → Text"
echo "   - Set Font to: JetBrainsMono Nerd Font Mono (14pt)"
echo "   - Preferences → Profiles → Colors"
echo "   - Import: https://github.com/catppuccin/iterm/blob/main/colors/catppuccin-mocha.itermcolors"
echo ""
echo "2. Restart terminal: exec zsh"
echo ""
echo "3. In tmux, press Ctrl-Space + I to install plugins"
echo ""
echo "4. Open nvim - plugins will auto-install"
echo ""

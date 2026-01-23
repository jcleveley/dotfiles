# Dotfiles

My lean CLI setup with Catppuccin Mocha theme.

## Tools

- **Shell**: zsh with Antidote
- **Prompt**: Starship
- **Terminal Multiplexer**: tmux
- **Editor**: Neovim
- **Utilities**: bat, eza, zoxide
- **Font**: JetBrains Mono Nerd Font
- **Theme**: Catppuccin Mocha

## Features

- 🎨 Catppuccin Mocha colors throughout
- ⚡ Fast fuzzy finding with Telescope
- 📁 Auto-completion and suggestions
- 🔍 Syntax highlighting
- 📂 Smart directory jumping with z
- 🔄 Mac clipboard integration in tmux

## Installation

1. Clone this repo:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
```

2. Run setup script:
```bash
chmod +x setup-cli.sh
./setup-cli.sh
```

3. Copy config files:
```bash
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
mkdir -p ~/.config
cp -r config/* ~/.config/
```

4. Restart terminal: `exec zsh`

5. In tmux, press `Ctrl-Space + I` to install plugins

6. Open nvim - plugins will auto-install

## Key Bindings

### tmux (Prefix: Ctrl-Space)
- `Ctrl-Space |` - Split vertical
- `Ctrl-Space -` - Split horizontal
- `Ctrl-Space h/j/k/l` - Navigate panes
- `Ctrl-Space H/J/K/L` - Resize panes

### Neovim (Leader: Space)
- `Space e` - File explorer
- `Space ff` - Fuzzy find files
- `Space fg` - Live grep
- `Space fb` - Browse buffers

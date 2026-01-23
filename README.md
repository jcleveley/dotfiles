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

1. Clone this repo to your home directory:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run setup script (installs tools and creates symlinks):
```bash
chmod +x setup-cli.sh
./setup-cli.sh
```

The script will:
- Install all required tools via Homebrew
- Create symlinks from `~/.zshrc`, `~/.tmux.conf`, etc. to files in `~/dotfiles`
- Backup any existing config files to `*.backup`

**Why symlinks?** Any changes you make to `~/.zshrc` are automatically in your git repo since it's a symlink to `~/dotfiles/.zshrc`!

3. Follow the post-install steps from the script output

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

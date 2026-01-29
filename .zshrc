export PATH="$HOME/.local/bin:$PATH"
# ============================================================================
# ZSH Configuration - Lean & Clean with Antidote
# ============================================================================

# Antidote plugin manager
ANTIDOTE_HOME=${ZDOTDIR:-~}/.antidote
if [[ ! -d $ANTIDOTE_HOME ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_HOME
fi
source $ANTIDOTE_HOME/antidote.zsh

# Plugins (Antidote will auto-install these)
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.txt
if [[ ! -f $zsh_plugins ]]; then
  cat > $zsh_plugins <<PLUGINS
# Completions and suggestions
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting

# Smart directory jumping
:agkozak/zsh-z
PLUGINS
fi

# Load plugins
antidote load $zsh_plugins

# ============================================================================
# Basic ZSH Config
# ============================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Auto cd
setopt AUTO_CD

# ============================================================================
# Aliases
# ============================================================================

# eza (ls replacement)
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -l'
alias la='eza --icons --group-directories-first -la'
alias lt='eza --icons --group-directories-first --tree'
alias v='nvim'

# bat (cat replacement)
alias cat='bat --theme=Catppuccin-mocha'

# General
alias ..='cd ..'
alias ...='cd ../..'

# ============================================================================
# Environment
# ============================================================================

# bat theme
export BAT_THEME="Catppuccin-mocha"

# eza colors (Catppuccin Mocha palette)
export EZA_COLORS="da=38;5;245:sb=38;5;245:sn=38;5;245:uu=38;5;245:un=38;5;245:gu=38;5;245:gn=38;5;245"

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# ============================================================================
# Starship Prompt
# ============================================================================

eval "$(starship init zsh)"

# ============================================================================
# fzf - Fuzzy Finder
# ============================================================================

# fzf Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# fzf key bindings and completion (Ctrl+R for history search)
eval "$(fzf --zsh)"

# ============================================================================
# Autosuggestion customization (Catppuccin Mocha)
# ============================================================================

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70'

# Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

## Add inb zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

## Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::archlinux

# Keybindings
bindkey -e
bindkey -M emacs '^p' history-search-backward
bindkey -M emacs '^n' history-search-forward

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-zu}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLOR}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

### new executables
zstyle ':completion:*' rehash true

# Enable history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups

# Variables
export EDITOR='emacs -nw -q'
export BAT_THEME=ansi

# Aliases
alias l='eza '
alias la='eza -la --group-directories-first --icons=always '
alias lt='eza --tree '

alias cat='bat'
alias top='htop'

# Create an alias to interact with the repository
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# Prompt
eval "$(starship init zsh)"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

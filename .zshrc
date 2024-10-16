# Enable autocomplete commands
autoload -U compinit
compinit

# Autocomplete via keys
zstyle ':completion:*' menu select

# Find news executable on $PATH
zstyle ':completion:*' rehash true

# Auntocomplete alias
setopt completealiases

# Enable history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Ignore deplicates in history
setopt HIST_IGNORE_DUPS

# Remenber lasts visited directories 
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Delete duplicate entries
setopt pushdignoredups

## Revert operators +/-.
setopt pushdminus

# Plugins
PLUGDIR=/usr/share/zsh/plugins

## Syntax highlighting
source $PLUGDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


## Automatic autocomplete suggestions 
source $PLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

## Search substring of command on history
source $PLUGDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
### Use keys Ctrl-p and Ctrl-n for navigate
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Enable colors
autoload -U colors && colors

# Help command
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help
alias help=run-help

# Prompt
PROMPT=$'%F{red}[%F{yellow}%{\e[3m%}%n%F{green}@%F{blue}%m%{\e[0m%} %F{magenta}%~%F{red}]%F{white}$ %f'

# Alias

## personal
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias agenda='/usr/bin/git --git-dir=$HOME/.agenda.git/ --work-tree=$HOME'

## ls to eza
alias ls='eza'
alias la='eza -la --group-directories-first --icons'
alias lt='eza --tree'

## cat to bat
export BAT_THEME="ansi"
alias cat='bat'

unsetopt PROMPT_SP

export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

[ -f $HOME/.theme ] && . $HOME/.theme || echo "THEME_SLECTED not exist"

cd $HOME

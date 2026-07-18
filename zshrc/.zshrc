export PATH="$HOME/.fzf/bin:$PATH"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias ls='ls --color'
alias c='clear'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gg='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias lg='lazygit'
alias gs='git status'
alias gp='git push origin'
alias gac='git add . && git commit -m'
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias wez='nvim /mnt/c/Users/ironm/.wezterm.lua'
alias glaze='nvim /mnt/c/Users/ironm/.glzr/glazewm/config.yaml'

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

export PATH="$PATH:/opt/nvim/"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Loads nvm

PATH="$PATH":"$HOME/.local/scripts/"
bindkey -s ^f "tmux-sessionizer\n"

# shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#-----------------------
# keep wsl distro alive
#-----------------------
if ! pgrep -u "$(whoami)" -x "dbus-daemon" > /dev/null; then
   dbus-launch true
fi

if command -v dbus-launch &> /dev/null && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax 2>/dev/null)"
fi
export PATH="/home/trip/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/trip/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export DATABASE_PASSWORD="420"


# Added by Antigravity CLI installer
export PATH="/home/trip/.local/bin:$PATH"

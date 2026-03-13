# =============================================================================
# ZSH Configuration
# =============================================================================

# =============================================================================
# Oh My Zsh Configuration
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Update behavior
zstyle ':omz:update' mode reminder

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    sudo
    colored-man-pages
    command-not-found
    history-substring-search
    dirhistory
)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh

# =============================================================================
# Environment Variables
# =============================================================================
# PATH configuration
export PATH="/usr/local/go/bin:$HOME/go/bin:/home/luka/.npm-global/bin:/snap/bin:/home/luka/.cargo/bin:/home/luka/.cache/.bun/bin:/opt/nvim-linux64/bin:/home/luka/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Go configuration
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"


# =============================================================================
# History Configuration
# =============================================================================
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Correction options
setopt CORRECT
setopt CORRECT_ALL

# =============================================================================
# Aliases
# =============================================================================

# --- File Listing ---
if command -v lsd >/dev/null 2>&1; then
    alias ls='lsd --color=auto'
    alias ll='lsd -la'
    alias la='lsd -a'
    alias l='lsd'
    alias lsg='lsd --group-directories-first'
    alias tree='lsd --tree'
elif command -v exa >/dev/null 2>&1; then
    alias ls='exa --color=auto --group-directories-first'
    alias ll='exa -la --git --header --group-directories-first'
    alias la='exa -a --group-directories-first'
    alias l='exa --group-directories-first'
    alias lsg='exa --color=auto --group-directories-first'
    alias tree='exa --tree --group-directories-first'
else
    alias ls='ls --color=auto'
    alias ll='ls -la'
    alias la='ls -A'
    alias l='ls -CF'
    alias lsg='ls --group-directories-first --color=auto'
fi

# --- Search & Text Processing ---
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Modern cat replacement
if command -v bat >/dev/null 2>&1; then
    alias cat='bat --style=plain --wrap=never'
    alias less='bat --style=plain --wrap=never --pager=less'
fi

# --- Directory Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Enhanced directory creation
mkcd() { mkdir -p "$1" && cd "$1"; }

# Archive extraction
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# --- File Operations ---
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# --- Git ---
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
alias gl='git log --oneline'
alias gco='git checkout'
alias gb='git branch'
alias gr='git remote'
alias gcl='git clone'
alias gst='git stash'
alias gsp='git stash pop'
alias gpl='git pull'
alias gsh='git show'
alias gre='git reset'
alias grh='git reset --hard'
alias gcm='git commit -m'
alias gam='git commit --amend'
alias gaa='git add --all'
alias gclean='git clean -fd'
alias glog='git log --graph --oneline --decorate --all'

# --- Editor ---
alias vim='nvim'
alias v='nvim'

# --- System Management ---
alias apt='sudo apt'
alias aptu='sudo apt update'
alias apti='sudo apt install'
alias apts='apt search'
alias update='sudo apt update && sudo apt upgrade -y'

# --- Development Tools ---
alias py='python3'
alias pip='python3 -m pip'
alias node='nodejs'
alias npm='npm --no-audit --no-fund'
alias lg='lazygit'

# --- Virtual Environment ---
alias venv='python3 -m venv .venv'
alias activate='source .venv/bin/activate'

# --- System Monitoring ---
alias top='htop'
alias btm='bottom'
alias sysinfo='fastfetch'
alias mem='free -h'
alias disk='df -h'
alias ports='netstat -tulanp'

# --- Network & Utilities ---
alias get='curl -LO'
alias ipinfo='curl ipinfo.io'
alias weather='curl wttr.in'
alias findf='fzf'
alias bc='bc -l'
alias w3m='w3m -B'

# --- Compression ---
alias untar='tar -xvf'
alias targz='tar -czvf'

# --- Window Manager ---
alias picom='/usr/local/bin/picom'
alias restart-polybar='polybar-msg cmd restart'
alias restart-wm='bspc wm -r'

# --- SSH ---
alias sshk='ssh-keygen -t ed25519'

# --- Quick Commands ---
alias q='exit'
alias c='clear'
alias h='history'

# --- funny ---
alias wtf='man'
alias fuck='killall'

# =============================================================================
# Key Bindings
# =============================================================================

# Edit line in editor with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# History substring search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =============================================================================
# External Tools Initialization
# =============================================================================

# Initialize zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# Startup Commands
# =============================================================================

# Run fastfetch on shell startup
fastfetch

# =============================================================================
# Powerlevel10k Configuration
# =============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/home/luka/.lmstudio/bin"

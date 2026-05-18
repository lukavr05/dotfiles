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

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8,italic'

# ── Commands ──────────────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[command]='fg=11,bold'                # bright yellow  — commands
ZSH_HIGHLIGHT_STYLES[builtin]='fg=2,bold'                 # aqua           — cd echo source…
ZSH_HIGHLIGHT_STYLES[function]='fg=12,bold'               # bright blue    — functions
ZSH_HIGHLIGHT_STYLES[alias]='fg=10,bold'                  # bright green   — aliases
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=10,italic'         # bright green   — *.pdf=zathura
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=10,bold,underline' # bright green   — global aliases
ZSH_HIGHLIGHT_STYLES[precommand]='fg=13,italic'           # bright magenta — sudo env nice…
ZSH_HIGHLIGHT_STYLES[arg0]='fg=11'                        # bright yellow  — command-position override
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=3,bold'           # yellow         — if then else fi for
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9,bold,underline' # bright red     — unrecognised token

# ── Arguments & paths ─────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[default]='fg=15'                     # fg             — plain arguments
ZSH_HIGHLIGHT_STYLES[path]='fg=15,underline'              # fg + underline — valid path on disk
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=7'                  # gray           — partial/incomplete path
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=12,italic,underline' # bright blue — auto-cd dirs
ZSH_HIGHLIGHT_STYLES[globbing]='fg=11,italic'             # bright yellow  — * ? ** […]

# ── Flags & options ───────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=12,italic' # bright blue    — -x
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=12,italic' # bright blue    — --long-flag

# ── Strings ───────────────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=10'               # bright green — 'literal'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=9'       # bright red   — unclosed '
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=10'               # bright green — "interpolated"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=9'       # bright red   — unclosed "
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=10,italic'        # bright green — $'escape\n'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=9'       # bright red   — unclosed $'

# ── String internals ──────────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=11'        # bright yellow  — $var inside "…"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=13'          # bright magenta — \n \t inside "…"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=13'          # bright magenta — escapes in $'…'

# ── Command & process substitution ────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=15'
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=15'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=13,bold'           # bright magenta — $( )
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=13,bold'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=15'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=13,bold'           # bright magenta — <( )
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=15'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=9'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=13,bold'           # bright magenta — ` `

# ── Operators & separators ────────────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=3,bold'                 # yellow         — ; | && ||
ZSH_HIGHLIGHT_STYLES[redirection]='fg=13,bold'                     # bright magenta — > >> < 2>&1
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=13'                             # bright magenta — named fds
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=13'                           # bright magenta — 2, etc.

# ── Assignment, history & comments ────────────────────────────────────────────
ZSH_HIGHLIGHT_STYLES[assign]='fg=11,italic'                        # bright yellow  — VAR=value
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=3,italic'              # yellow         — !! !$ !42
ZSH_HIGHLIGHT_STYLES[comment]='fg=8,italic'                        # dark gray      — # comments
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

setopt INTERACTIVE_COMMENTS


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
elif command -v eza >/dev/null 2>&1; then
    alias ls='eza --color=auto --group-directories-first'
    alias ll='eza -la --git --header --group-directories-first'
    alias la='eza -a --group-directories-first'
    alias l='eza --group-directories-first'
    alias lsg='eza --color=auto --group-directories-first'
    alias tree='eza --tree --group-directories-first'
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

# --- Git Helpers ---
if command -v delta >/dev/null 2>&1; then
    alias gd='delta'
    alias gdv='delta --diff-only'
fi

# --- Editor ---
alias vim='nvim'
alias v='nvim'

# --- System Management ---
alias nala='sudo nala'
alias update='sudo nala update && sudo nala upgrade -y'

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
alias wttr='curl wttr.in'
alias findf='fzf'
alias bc='bc -l'
alias rg='rg --color=auto'
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

# --- Terminal ---
alias kitty='$HOME/.local/kitty.app/bin/kitty'
alias q='exit'
alias c='clear'
alias h='history'
alias src='source .zshrc'

# --- OpenCode ---
alias oc='opencode'

# --- Applications ---
alias tidal='~/Applications/tidal-hifi-7.0.1.AppImage --no-sandbox'

# --- funny ---
alias wtf='man'

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

# opencode
export PATH=/home/luka/.opencode/bin:$PATH

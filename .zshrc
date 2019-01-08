export ZSH="/home/adam/.oh-my-zsh"

# History tweaks 
HISTSIZE=10000000

SAVEHIST=10000000

 # Treat the '!' character specially during expansion.
setopt BANG_HIST
# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

# Other shell options
setopt completealiases
export COMPLETION_WAITING_DOTS=false

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  catimg
  colored-man-pages
  docker
  encode64
  jira
  jsontools
  pip
  python
  screen
  vagrant
  vscode
  web-search
  zsh-completions
)

# Plugin loaders
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-antigen/antigen.zsh
antigen bundle wbingli/zsh-wakatime
antigen bundle srijanshetty/zsh-pip-completion
antigen bundle gerges/oh-my-zsh-jira-plus
antigen bundle RobSis/zsh-completion-generator
antigen bundle urbainvaes/fzf-marks
antigen bundle wfxr/forgit
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle djui/alias-tips
antigen bundle zdharma/fast-syntax-highlighting  # MUST BE LAST!
antigen bundle trapd00r/zsh-syntax-highlighting-filetypes
antigen apply

# fzf goodies
[ -f /home/adam/.fzf.zsh ] && source /home/adam/.fzf.zsh
if [ -d /home/adam/.fzf-scripts ]; then
    PATH=$PATH:/home/adam/.fzf-scripts
fi
export FZF_DEFAULT_OPTS='--ansi'
export FZF_DEFAULT_COMMAND='fdfind --color always --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "[[ -d {} ]] && ls --color=always -lh {} || bat --color always --italic-text always --decorations never --pager never --line-range :1000 {}"'
export FZF_ALT_C_COMMAND='fdfind --color always --type d --follow'
export FZF_ALT_C_OPTS='--preview "ls --color=always -lh {}"'
export FZF_MARKS_COMMAND=$'fzf --height 40% --reverse --preview "echo {} | cut -d \\  -f3- | tr -d \'\\n\' | xargs -0 ls -lh --color=always"'
export FZF_COMPLETION_OPTS=$'--preview "\
    if [[ -d {} ]]; then \
        ls --color=always -lh {} \
    elif [[ -f {} ]]; then \
        bat --color always --italic-text always --decorations never --pager never --line-range :1000 {} \
    elif [[ -v {} ]]; then \
        eval \'tmp=\\${}\' \
        echo $tmp \
    elif [[ -n $(echo {} | awk \'{ print $2 }\') && -e /proc/$(echo {} | awk \'{ print $2 }\') ]]; then \
        pstree -sUH $(echo {} | awk \'{ print $2 }\') $(echo {} | awk \'{ print $2 }\') \
    elif [[ -n $(grep \'Host {}\' $HOME/.ssh/config) ]]; then \
        start=$(grep -n \'Host {}\' $HOME/.ssh/config | cut -f1 -d:) \
        bat --color always --italic-text always --decorations never --pager never --line-range $start:$(( $start + 2 )) $HOME/.ssh/config \
    else \
        grep "{}" /etc/hosts \
    fi"'

_fzf_compgen_path() {
  fdfind --hidden --follow --exclude ".git" . "$1" --color always
}
_fzf_compgen_dir() {
  fdfind --type d --hidden --follow --exclude ".git" . "$1" --color always
}

# Specify command line syntax highlighters
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main pattern brackets cursor line regexp root url)

# THEME

# git decorator
source /usr/lib/git-core/git-sh-prompt
GIT_PS1_SHOWDIRTYSTATE=1

# Bat theme
export BAT_THEME="TwoDark"
export BAT_STYLE=full

# ripgrep config
export RIPGREP_CONFIG_PATH=/home/$USER/.ripgrep

# PS1
if [[ $EUID -ne 0 ]]; then
    if [[ $JETBRAINS_TERM == 1 ]]; then
        ZSH_THEME=bira
    else
        PS1=$'%{\e[\033[01;32m%}┌────%{\e[\033[00m%}${debian_chroot:+($debian_chroot)}%{\e[\033[01;32m%}%n@%M%{\e[\033[00m%}:%{\e[\033[01;34m%}%(5~|%-1~/.../%3~|%4~)%{\e[$(tput setaf 1)$(__git_ps1 " (%s)")%}\n%{\e[\033[01;32m%}└─\[%{\e[\033[00m%}\$ '
    fi
else
    PS1=$'%{\e[\033[01;32m%}┌────%{\e[\033[32m%}${debian_chroot:+($debian_chroot)}%{\e[\033[01;31m%}%n%{\e[\033[32m%}@%M%{\e[\033[00m%}:%{\e[\033[01;34m%}%(5~|%-1~/.../%3~|%4~)%{\e[$(tput setaf 1)%}$(__git_ps1 " (%s)")\n%{\e[\033[01;32m%}└─\[%{\e[\033[00m%}\$ '
fi

# import aliases
if [ -f /home/adam/.bash_aliases ]; then
    source /home/adam/.bash_aliases
fi

# other imports
autoload -U compinit && compinit
zmodload -i zsh/complist

# fpath
fpath=(/home/adam/.zsh/ /home/adam/Code/misc/scripts/zsh $fpath)

# Environment
export PATH=$PATH:/usr/racket/bin:/home/adam/Code/misc/scripts:/home/adam/.gopath/bin:/home/adam/Code/misc/scripts/zsh/zemojify:/sbin
export CLASSPATH=/home/adam/Java/lib
export EDITOR=vim
export RANGER_LOAD_DEFAULT_RC=false
export GOPATH=/home/adam/.gopath

# Activate anaconda
source /home/adam/.anaconda3/etc/profile.d/conda.sh

# Bad aliases
unalias _
unsetopt correctall

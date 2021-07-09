export ZSH="$HOME/.oh-my-zsh"

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
export VIRTUAL_ENV_DISABLE_PROMPT=1
tabs -4
export BASH_ENV="$HOME/.bashrc"

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
  vi-mode
)

# Plugin loaders
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-antigen/antigen.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle wbingli/zsh-wakatime
antigen bundle srijanshetty/zsh-pip-completion
antigen bundle gerges/oh-my-zsh-jira-plus
antigen bundle RobSis/zsh-completion-generator
antigen bundle urbainvaes/fzf-marks
antigen bundle wfxr/forgit
antigen bundle djui/alias-tips
antigen bundle hlissner/zsh-autopair
antigen bundle zdharma/fast-syntax-highlighting  # MUST BE LAST!
antigen apply

# fzf goodies
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -d $HOME/.fzf-scripts ] && PATH=$PATH:$HOME/.fzf-scripts
export FZF_DEFAULT_OPTS='--ansi'
export FZF_DEFAULT_COMMAND='fdfind --color always --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "[[ -d {} ]] && colorls --color=always -lh --git-status {} || /usr/bin/bat --color always --italic-text always --decorations never --pager never --line-range :1000 {}"'
export FZF_ALT_C_COMMAND='fdfind --color always --type d --follow'
export FZF_ALT_C_OPTS='--preview "colorls --color=always -lh --git-status {}"'
export FZF_MARKS_COMMAND=$'fzf --height 40% --reverse --preview "echo {} | cut -d \\  -f3- | tr -d \'\\n\' | xargs -0 colorls -lh --color=always --git-status"'
export FZF_COMPLETION_OPTS=$'--preview "\
    if [[ -d {} ]]; then \
        colorls --color=always -lh --git-status {} \
    elif [[ -f {} ]]; then \
        /usr/bin/bat --color always --italic-text always --decorations never --pager never --line-range :1000 {} \
    elif [[ -v {} ]]; then \
        eval \'tmp=\\${}\' \
        echo $tmp \
    elif [[ -n $(echo {} | awk \'{ print $2 }\') && -e /proc/$(echo {} | awk \'{ print $2 }\') ]]; then \
        pstree -sUH $(echo {} | awk \'{ print $2 }\') $(echo {} | awk \'{ print $2 }\') \
    elif [[ -n $(grep \'Host {}\' $HOME/.ssh/config) ]]; then \
        start=$(grep -n \'Host {}\' $HOME/.ssh/config | cut -f1 -d:) \
        /usr/bin/bat --color always --italic-text always -l ssh_config --decorations never --pager never --line-range $start:$(( $start + 2 )) $HOME/.ssh/config \
    else \
        /usr/bin/bat --color always --italic-text always --decorations never --pager never /etc/hosts | grep --color=always "{}" \
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
export RIPGREP_CONFIG_PATH=/$HOME/.ripgrep

# function to get python venv info
function venv_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${VIRTUAL_ENV##*/}"
    else
        venv=''
    fi
    [[ -n "$venv" ]] && echo "%{\e[\033[01;93m%}($venv) "
}

# virtualenv wrapper setup
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# PS1
if [[ $EUID -ne 0 ]]; then
    PS1=$'%{\e[\033[01;32m%}┌────%{\e[\033[00m%}${debian_chroot:+($debian_chroot)}%{\e[\033[01;32m%}%n@%M%{\e[\033[00m%}:%{\e[\033[01;34m%}%(5~|%-1~/.../%3~|%4~)%{\e[$(tput setaf 1)$(__git_ps1 " (%s)")%} $(venv_info)\n%{\e[\033[01;32m%}└─\[%{\e[\033[00m%}\$ '
else
    PS1=$'%{\e[\033[01;32m%}┌────%{\e[\033[32m%}${debian_chroot:+($debian_chroot)}%{\e[\033[01;31m%}%n%{\e[\033[32m%}@%M%{\e[\033[00m%}:%{\e[\033[01;34m%}%(5~|%-1~/.../%3~|%4~)%{\e[$(tput setaf 1)%}$(__git_ps1 " (%s)")\n%{\e[\033[01;32m%}└─\[%{\e[\033[00m%}\# '
fi

# other imports
autoload -U compinit && compinit
zmodload -i zsh/complist

# fpath
fpath=($HOME/.zsh/ $HOME/dev/scripts/zsh $fpath)

# environment
export PATH=$PATH:/usr/racket/bin:$HOME/dev/scripts:$HOME/.gopath/bin:$HOME/dev/scripts/zsh/zemojify:/sbin:$HOME/.local/bin/:$HOME/adam/.gem/ruby/2.7.0/bin
export CLASSPATH=$HOME/Java/lib
export EDITOR=vim
export RANGER_LOAD_DEFAULT_RC=false
export GOPATH=$HOME/.gopath
export MANPAGER=export MANPAGER="sh -c 'col -b | bat --tabs=0 -l man -p'"
#export DOCKER_HOST=tcp://$HOST:2376
#export DOCKER_TLS_VERIFY=1

# activate anaconda
source $HOME/.anaconda3/etc/profile.d/conda.sh
conda deactivate

# tab completions
source $(dirname $(gem which colorls))/tab_complete.sh  # colorls

# bad aliases
unalias _
unalias sp
unsetopt correctall
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="vi emacs nano ed :q"

# command line keybinds
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}

# press CTRL+S to prepend "sudo" to current command
zle -N sudo-command-line
bindkey "^s" sudo-command-line  

# import aliases
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases

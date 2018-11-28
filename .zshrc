# Path to oh-my-zsh installation.
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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# git decorator
source /usr/lib/git-core/git-sh-prompt
GIT_PS1_SHOWDIRTYSTATE=1

# Bat theme
export BAT_THEME="TwoDark"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  git-extras
  catimg
  colored-man-pages
  docker
  encode64
  jira
  jsontools
  npm
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
antigen bundle urbainvaes/fzf-marks
antigen bundle wfxr/forgit
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle djui/alias-tips
antigen bundle zdharma/fast-syntax-highlighting  # MUST BE LAST!
antigen bundle trapd00r/zsh-syntax-highlighting-filetypes
antigen apply

# fzf goodies
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -d ~/.fzf-scripts ]; then
    PATH=$PATH:~/.fzf-scripts
fi


# PS1
if [[ $EUID -ne 0 ]]; then
    if [[ $JETBRAINS_TERM == 1 ]]; then
        ZSH_THEME=bira
    else
        PS1=$'%{\e[\033[01;32m%}┌────%{\e[\033[00m%}${debian_chroot:+($debian_chroot)}%{\e[\033[01;32m%}%n@%M%{\e[\033[00m%}:%{\e[\033[01;34m%}%(5~|%-1~/…/%3~|%4~)%{\e[$(tput setaf 1)$(__git_ps1 " (%s)")%}\n%{\e[\033[01;32m└─[%}%{\e[\033[00m%}\$ '
    fi
else
    PS1=$'%{\e[\033[01;32m%}┌────%{\e[\033[32m%}${debian_chroot:+($debian_chroot)}%{\e[\033[01;31m%}%n%{\e[\033[32m%}@%M%{\e[\033[00m%}:%{\e[\033[01;34m%}%(5~|%-1~/…/%3~|%4~)%{\e[$(tput setaf 1)%}$(__git_ps1 " (%s)")\n%{\e[\033[01;32m%}└─[%{\e[\033[00m%}\$ '
fi

# import aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# other imports
scrdir=~/Code/misc/scripts/zsh
if [ -d $scrdir ]; then
    for plug in $(ls $scrdir); do
        source $scrdir/$plug
    done
fi
autoload -U compinit && compinit
zmodload -i zsh/complist

# fpath
fpath=(/home/adam/.zsh/ $fpath)

# Environment
export PATH=$PATH:/usr/racket/bin:~/Code/misc/scripts:~/.gopath/bin
export CLASSPATH=~/Java/lib
export EDITOR=vim
export RANGER_LOAD_DEFAULT_RC=false
export GOPATH=~/.gopath

# Activate anaconda
source /home/adam/anaconda3/etc/profile.d/conda.sh

# Bad aliases
unalias _
unsetopt correctall

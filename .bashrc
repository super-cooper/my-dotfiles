#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    # WakaTime bash plugin
    source ~/.wakatime.sh
fi
# git decorator
source /usr/lib/git-core/git-sh-prompt
GIT_PS1_SHOWDIRTYSTATE=1

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [[ $EUID -ne 0 ]]; then
    # Scripts for git completion
    source ~/.gitcompletion.sh
fi

if [ "$color_prompt" = yes ]; then
    if [[ $EUID -ne 0 ]]; then
        PS1='\[\033[01;32m\]┌────\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[$(tput setaf 1)\]$(__git_ps1 " (%s)")\n\[\033[01;32m\]└─[\[\033[00m\]\$ '
    else
        PS1='\[\033[01;32m\]┌────\[\033[32m\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[32m\]@\h\[\033[00m\]:\[\033[01;34m\]\w\[$(tput setaf 1)\]$(__git_ps1 " (%s)")\n\[\033[01;32m\]└─[\[\033[00m\]\$ '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Syntax theme for bat
export BAT_THEME="TwoDark"

# import bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Environment
export PROMPT_DIRTRIM=3

export PATH=$PATH:/usr/racket/bin:~/Code/misc/scripts:~/.gopath/bin
export CLASSPATH=~/Java/lib
export EDITOR=vim
export RANGER_LOAD_DEFAULT_RC=false

export GOPATH=~/.gopath

# fzf goodies
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.fzf-marks.bash ] && source ~/.fzf-marks.bash
if [ -d ~/.fzf-scripts ]; then
    PATH=$PATH:~/.fzf-scripts
fi
[ -f ~/.forgit.sh ] && source ~/.forgit.sh

# Activate anaconda
. /home/adam/anaconda3/etc/profile.d/conda.sh
eval "$(register-python-argcomplete conda)"

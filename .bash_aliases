# Program replacements
alias git=hub
alias g=hub
alias cat=bat

# macros for editing bash configs
alias reset='source ~/.zshrc'
alias bashrc='vim ~/.bashrc && reset'
alias zshrc='vim ~/.zshrc && reset'
alias aliases='vim ~/.bash_aliases && reset'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    matches () { grep --color -E "$1|$" "${@:1}" ; }
    alias diff=colordiff
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'

# Need not to press cd ../../ ad infinitum
u() {
    cd $(eval printf "../%0.s" {1..$1})
}

# More cd aliases
alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories

# mkdir fix
alias mkdir='mkdir -p'

# make xclip do what I want
alias xclip='xclip -selection clipboard'

# dotfiles version control/backup
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dtf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# misc
alias please='sudo $(fc -ln -1)'
eval $(thefuck --alias --enable-experimental-instant-mode)

# Git to fzf replacers 
alias gitignore=gi

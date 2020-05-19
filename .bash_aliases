# Program replacements
eval $(hub alias -s)
alias bat=/usr/bin/batcat
alias cat='bat --italic-text=always --decorations=auto'
alias find=fdfind
alias fd=fdfind
alias wtf='wtf --config=/tmp/wtfconfig.yml'
alias {ed,emacs,nano,vi}=vim
alias grep=rg

# macros for editing bash configs
alias reset='source ~/.zshrc'
alias bashrc='vim ~/.bashrc && reset'
alias zshrc='vim ~/.zshrc && reset'
alias aliases='vim ~/.bash_aliases && reset'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -h'
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
alias lal='ls -Al'
alias lla='ls -lA'
alias lc='colorls --git-status'

# Need not to press cd ../../ ad infinitum
u() {
    cd $(eval printf "../%0.s" {1..$1})
}

# Typos
alias cd..='cd ..'       # Common misspelling for going up one directory
alias :q=exit

# mkdir fix
alias mkdir='mkdir -p'
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# make xclip do what I want
alias xclip='xclip -selection clipboard'

# dotfiles version control/backup
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dtf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias env-update='dtf fetch && dtf pull --rebase && dtf pull --recurse-submodules && go get -v -u all && gnome-shell-extension-installer --update'

# misc
alias please='sudo $(fc -ln -1)'
eval $(thefuck --alias --enable-experimental-instant-mode)
alias emojify=zemojify
hex() {
    hexyl $@ | less
}
alias calc=qalc
[ -z "$(command -v open)" ] && alias open=xdg-open

# Git to fzf replacers 
alias gitignore=gi

# apt helpers
apt-unpin-all() {
    sudo apt-mark showhold | sudo awk '{ print $1, "install" }' | sudo dpkg --set-selections
}

# minecraft server
alias memecraft="sudo tmux new-session 'docker logs -f memecraft' \; split-window '/home/adam/.gopath/bin/rcon-cli --config /home/adam/Containers/memecraft/rcon.yml'"


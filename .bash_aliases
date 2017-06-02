# General
alias sovs='source ~/.profile'
alias fuck='sudo $(history -p \!\!)'

# Git
alias g="git"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Apt aliases
alias fancy='sudo pacman -Syu'

# Config edit
alias eV="nvim $MYVIMRC"
alias eB='nvim ~/.bashrc'
alias eBA='nvim ~/.bash_aliases'
alias eP='nvim ~/.profile'
alias eGC='nvim ~/.gitconfig'
alias eT='nvim ~/.tmux.conf'
alias eI='nvim ~/.config/i3/config'
alias ePOLY='nvim ~/.config/polybar/config'


alias antlr4='java -jar /usr/local/lib/antlr-4.6-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

# Administration
alias addx='sudo chmod +x '

# Vallgrind
alias vfull='valgrind --leak-check=full --track-origins=yes'

# some ls aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'

alias e='nvim'
alias vim='nvim'

# Clear
alias c='clear'

#VM
alias vshut='VBoxManage controlvm Windows savestate'
alias vstart='VBoxManage startvm Windows'

#Speedswapper
alias speed='xmodmap ~/.bootstrap/.speedswapper'
# Calculator math control
alias bc='bc -l'
# Show all ports
alias ports='netstat -tulanp'
# Show history
alias h='history'
# pass options to free ## 
alias meminfo='free -m -l -t'
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# Get server cpu info ##
alias cpuinfo='lscpu'
# older system use /proc/cpuinfo ##
#alias cpuinfo='less /proc/cpuinfo' ##
# get GPU ram on desktop / laptop## 
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
# top is atop, just like vi is vim
alias top='htop'
#Open last vim file
alias lvim="nvim -c \"normal '0\""
# Show ip
alias myip='curl http://ipecho.net/plain; echo'

# Tmux 
alias tmux='\tmux -2'
alias tmx="tmux new -s"
alias tmxa="tmux attach"
alias tmxl="tmux ls"
alias tmxc="vim ~/.tmux.conf"
alias tmxk="tmux kill-session -t"
alias tmxkbconf="tmux kill-session -t bconf"
alias tmxkding="tmux kill-session -t dings"
alias tmxwindows="tmux list-windows"

# Tmuxinator
alias bconf="tmuxinator start bconf"
alias dings="tmuxinator start dings"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

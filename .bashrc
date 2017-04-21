# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

############################
# =>       General         #
############################
screenfetch
GOPATH="$HOME/go"
export GOPATH
export EDITOR=/usr/bin/nvim
export MYVIMRC='~/.vimrc'

# Set terminal control scheme to that of Vi
# - Specify non standard input keys in ~/.inputrc 
set -o vi

# Command history 
HISTFILE="$HOME/.history/$(date -u +%Y/%m/%d)_${HOSTNAME}_$$"
PROMPT_COMMAND="history -a"
mkdir -p $(dirname ${HISTFILE})
shopt -s histappend

## 256 colors 
export TERM=xterm-256color
############################
#       Functions          #
############################

# colored man pages
man() 
{
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[34;5;31m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

mkcd() 
{ 
    mkdir -p "$1" && cd "$1"; 
}

rmspace() 
{  
    if [ -f "$1" ]; then
        rename 's/ /_/g' "$1"; 
    elif [ "$1" = "-r" ]; then
        read -p "Are you sure you want to do this on $PWD? " ANSWER
        case $ANSWER in
            [Yy]* ) find . -depth -name "* *" -execdir rename 's/ /_/g' "{}" \; ;;
            [Nn]* )                                                             ;;
            * ) echo "Please answer yes or no."                                 ;;
        esac
    else
        echo "Usage: rmspace [-r]|[file]"
        echo "Example: rmspace \"Hello World\" which renames it to \"Hello_World\"."
        echo "Or: rmspace -r to recursively remove spaces"
        echo "in all filenames in this dir and sub directories."
    fi
}

# Show symbolic links in curr dir
symbolic() { 
    find . -maxdepth 1 -type l -print0 | xargs -0 ls -lh --color=auto
}                                                         

# Extract archives - use: extract <archive> [directory] 
# Credits to https://github.com/jelly/Dotfiles/blob/master/.zshrc
extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2|*.tbz2|*.tbz)         tar xvjf "$1" ;;
            *.tgz)                          tar zxvf "$1" ;;
            *.tar.gz)                       tar xvzf "$1" ;;
            *.tar.xz)                       tar xvJf "$1" ;;
            *.tar)                          tar xvf "$1" ;;
            *.rar)                          7z x "$1" ;;
            *.zip)                          unzip "$1" ;;
            *.7z)                           7z x "$1" ;;
            *.lzo)                          lzop -d  "$1" ;;
            *.gz)                           gunzip "$1" ;;
            *.bz2)                          bunzip2 "$1" ;;
            *.Z)                            uncompress "$1" ;;
            *.xz|*.txz|*.lzma|*.tlz)        xz -d "$1" ;;
            *) echo "Sorry, '$1' could not be decompressed." ;;
        esac
    else
        echo "Usage: extract <archive> [directory]"
        echo "Example: extract presentation.zip."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.xz, tar, bz2,"
        echo "gz, tbz2, tbz, tgz, lzo,"
        echo "rar, zip, 7z, xz and lzma"
    fi
}


# Create an archive - use: archive <archive-type> <file>
# Credits to https://github.com/jelly/Dotfiles/blob/master/.zshrc
archive() { 
    echo "$1"
    if [ -n "$1" ] ; then
        case "$1" in
            tar.bz2)    tar cvjf    "${2%%/}.tar.bz2"   "${2%%/}/"  ;;
            tbz2)       tar cvjf    "${2%%/}.tbz2"      "${2%%/}/"  ;;
            tbz)        tar cvjf    "${2%%/}.tbz"       "${2%%/}/"  ;;       
            tar.xz)     tar cvJf    "${2%%/}.tar.xz"    "${2%%/}/"  ;;       
            tar.gz)     tar cvzf    "${2%%/}.tar.gz"    "${2%%/}/"  ;;
            tgz)        tar cvjf    "${2%%/}.tgz"       "${2%%/}/"  ;;
            tar)        tar cvf     "${2%%/}.tar"       "${2%%/}/"  ;;
            rar)        rar a       "${2}.rar"          "$2"        ;;
            zip)        zip -9      "${2}.zip"          "$2"        ;;
            7z)         7z a        "${2}.7z"           "$2"        ;;
            lzo)        lzop -v     "$2"                            ;;   
            gz)         gzip -v     "$2"                            ;;
            bz2)        bzip2 -v    "$2"                            ;;
            xz)         xz -v       "$2"                            ;; 
            lzma)       lzma -v     "$2"                            ;;  
            *) echo "Sorry, "$1" is an unknown archive type to me." ;;
        esac
    else
        echo "Usage:   archive <archive type> <file>"
        echo "Example: archive zip presentation"
        echo "Please specify archive type and source."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.gz, tar, bz2, gz, tbz2, tbz,"
        echo "tgz, lzo, rar, zip, 7z, xz and lzma." 
    fi
}

###########################
#  Standard bashrc stuff  #
###########################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; 
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;36m\]\u@\h\[\033[00m\]:\[\033[1;36m\]\w\[\033[00m\]\$ '
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

#Alias definitions
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

[ -s "/home/peter/.dnx/dnvm/dnvm.sh" ] && . "/home/peter/.dnx/dnvm/dnvm.sh" # Load dnvm

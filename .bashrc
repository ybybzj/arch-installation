# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Use default editor
export EDITOR="vim"

#google-chrome

alias google-chrome='google-chrome-stable'
# nvidia-settings in optimus environment
alias nv-settings='optirun -b none nvidia-settings-origin -c 8'
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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

###git settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
source ~/.my_bashrc/git-prompt.sh



# colors
# color_bold=$(tput bold)
# color_reset=$(tput sgr0)
# color_red="$(tput setaf 1)"
# color_light_red="$(tput bold ; tput setaf 1)"
# color_green="$(tput setaf 2)"
# color_light_green=$(tput bold; tput setaf 2)
# color_dark_grey=$(tput bold; tput setaf 0)
# color_light_grey="$(tput setaf 7)"
# color_yellow="$(tput setaf 3)"
# color_light_yellow=$(tput bold; tput setaf 3)
# color_blue="$(tput setaf 4)"
# color_light_blue="$(tput bold; tput setaf 4)"
# color_purple="$(tput setaf 5)"
# color_pink="$(tput bold; tput setaf 5)"
# color_white="$(tput setaf 7)"
# color_black="$(tput setaf 8)"
# color_cygan="$(tput bold; tput setaf 6)"
# color_light_cygan=$(tput setaf 6)
# color_magenta="$(tput setaf 10)"
source ~/.my_bashrc/cli-color.sh
# Add git to the terminal prompt

## Git aliases from TJ Holowaychuk
alias gitd="git diff | subl"
alias gita="git add"
alias gitbd="git branch -D"
alias gits="git status"
alias gitc="git commit -m"
alias gitca="git commit -a -m"
#alias gm="git merge --no-ff"
#alias gpt="git push --tags"
#alias gp="git push"
#alias grh="git reset --hard"
alias gitb="git branch"
alias gitcob="git checkout -b"
alias gitco="git checkout"
#alias gba="git branch -a"
#alias gcp="git cherry-pick"
alias gitl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"
#alias gpom="git pull --rebase origin master"
#alias gpum="git pull --rebase upstream master"
# alias gitcd='cd "`git rev-parse --show-toplevel`"'

# Docker alias
alias dockercc="docker ps -aq -f \"status=exited\"| xargs docker rm -f"
alias dockerci="docker images -q -f \"dangling=true\" | xargs docker rmi -f"

#overwrite prompt title setting
# PS1='\[\e[1;31m\][\w]\n\t \u $ '
PROMPT_COMMAND='__git_ps1 "\[$BCyan\][\w]\n\[$BWhite\]\t \[$BYellow\]\u\[$Color_Off\]" " \\\$ "'

### setting ruby evironment
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
#export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"


### configure the npm global installation
#export NPM_PACKAGES="${HOME}/.npm-packages"
#export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
#export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
#unset MANPATH
#MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

#Rust Auto Completed
#export RUST_SRC_PATH="$HOME/src/rust/src"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

### set local executables
export PATH="$PATH:./node_modules/.bin:$HOME/my_bins"

### source autojump script
source /usr/share/autojump/autojump.bash
### set ranger file manager
source ~/.my_bashrc/bash_automatic_cd.sh

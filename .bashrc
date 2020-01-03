## ------------------------
## ---- Set up aliases ----
## ------------------------

# Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

# Listing, directories, and motion
alias ll="ls -alrthF"
alias la="ls -A"
alias l="ls -CF"
alias m='less'
alias ..='cd ..'
alias ...='cd ..;cd ..'
alias ....='cd ..; cd ..; cd ..;'
alias md='mkdir'
alias cl='clear'
alias du='du -sh'
alias treeacl='tree -A -C -L 2'
alias ezgrep='xargs -I {} grep -r {} ./* --exclude-dir=build -InH'

# grep options
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31' # green for matches

# set locale
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# color in terminal
export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagaced'
export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31'

## -------------------------------
## ---- User-customized code  ----
## -------------------------------

# source custom bash config
if [[ -f ~/.bashrc_custom ]]; then
  source ~/.bashrc_custom
fi

if [[ -f ~/.bash_prompt ]]; then
  source ~/.bash_prompt
fi

# Java / mvn settings
alias setjdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias setjdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128M"

# Text and editor commands
alias em='/usr/local/bin/emacs -nw'

# Eternal bash history.
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


# Launch ipython from virtualenv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

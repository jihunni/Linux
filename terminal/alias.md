```
$ alias
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

$ vi .bash_aliases
# set alias
alias life1='ssh xxx.xx.xx.xx -Y' #-Y : to enable trusted X11 forwarding
alias hpc='ssh xxxxxxxxx@xxx.xxx.xx.xxx'

source .bash_aliases
```

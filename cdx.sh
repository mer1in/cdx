# cdx

# This script provides a set of aliases and functions to simplify navigation in the terminal.
# Key features include:
# - Quick access to project roots with 'cdr' command
# - Storing and accessing directories using single-letter aliases (e.g., 'sda' for directory A)
# - Fuzzy search for stored directories with 'cdswd-widget' function using 'fzf'
# - Handling reserved shortcuts like 'r' for git root and 't' for temporary folder

# Function to find the root directory of a Git or SVN project
__cdr() {
    SWD=`pwd`
    CWD=`pwd`
    while [ $CWD != '/' ]; do
        [[ -d .git || -d .svn ]] && echo $CWD && exit
        cd ..
        CWD=`pwd`
    done
    echo $SWD
}

# Set aliases for storing and accessing directories using single-letter shortcuts
for a in {a..z}; do
    alias "sd$a=[ -d ~/.cds ] || mkdir ~/.cds ; pwd > ~/.cds/$a; echo \"$a: \`cat ~/.cds/$a;\`\""
    alias "cd$a=[[ -d ~/.cds && -f ~/.cds/$a ]] && cd \`cat ~/.cds/$a\` && pwd || echo '$a doesnt exist'"
done

# Alias to change directory to the root of the current project
alias cdr='cd `__cdr`'

# Alias to create a temporary folder and change directory into it
alias cdt='_TMP=/tmp/`date +tmp_%Y%m%d_%H%M%S`; mkdir $_TMP; cd $_TMP'

# Handling reserved shortcuts
alias sdr='echo "r is reserved for git root"'
alias sdt='echo "t is reserved for tmp folder"'

# Function to display a list of stored directories for fuzzy searching
__cdswd() {
    [ -d ~/.cds ] || return
    for a in $(ls ~/.cds/|grep -v config); do
        echo "$a = $(cat ~/.cds/$a)"
    done | fzf +m -e \
        --bind 'ctrl-w:become(echo {}|sed "s#^. = ##")' \
        --preview='d=`echo {}|sed "s#^. = ##"`; \
            . ~/.bashrc 2>/dev/null ; \
            printf "`basename $d`\n"; \
            gs=`cd $d; git branch --show-current 2>/dev/null`; [ -n "$gs" ] \
                && printf "$gs\n"; \
            echo; ls -l --color $d'  \
        --header $'Γץ▒ Enter (cd selection) Γץ▒ (W)rite selection to command line \n\n'
}

# Function to handle selection in the fuzzy search for stored directories
cdswd-widget() {
    local selected="$(__cdswd "$@")"
    local cleaned="`echo $selected|sed 's/^. = //'`"
    # if selected starts with '. = ', enter was hit, otherwise it was ctrl+w
    if [[ $selected == $cleaned ]]; then
        READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
        READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
    else
        cd $cleaned
        printf "`pwd`\n"
    fi
}

# Binding to trigger the fuzzy search for stored directories
bind -m emacs-standard -x '"\C-gd": cdswd-widget'

# Binding to reload bashrc
bind -m emacs-standard -x '"\C-xr": . ~/.bashrc && echo "bashrc reloaded"'


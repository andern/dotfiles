#!/bin/bash
SYMLINKS=(
    ~/.vim
    ~/.vimrc
    ~/.Xdefaults
    ~/.bashrc
    ~/.gitconfig
    ~/.muttrc
    ~/.tmux.conf
    )
SOURCES=(
    vim
    vim/vimrc
    Xdefaults
    bash/bashrc
    gitconfig
    mutt/muttrc
    tmux/tmux.conf
    )

NO_ARGS=0
E_OPTERROR=85

function symlink {
    if [ ! -e $2 ]; then
        ln -rs $1 $2
    else
        echo "Did not create symlink $2 because file exists."
    fi
}

function unsymlink {
    if [ -L $1 ]; then
        rm $1
    else
        if [ -e $1 ]; then
            echo "Did not remove $1 because it is not a symlink."
        fi
    fi
}

install=true
while getopts ":iu" Option
do
    case $Option in
        i) install=true;;
        u) install=false;;
        *) echo "Invalid option."; exit $E_OPTERROR;
    esac
done

if [ $# -eq "$NO_ARGS" ] # No arguments
then
    echo "Usage: $0 -[iu]"
    echo
    echo "Options:"
    echo "  -i    create symlinks"
    echo "  -u    delete symlinks"
    exit $E_OPTERROR
fi

# Initialize submodules
git submodule init
git submodule update

if $install; then
    for i in "${!SYMLINKS[@]}"; do
    	symlink ${SOURCES[$i]} ${SYMLINKS[$i]}
    done
else
    for i in "${!SYMLINKS[@]}"; do
        unsymlink ${SYMLINKS[$i]}
    done
fi

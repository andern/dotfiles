#!/bin/bash
# Copyright 2014 Andreas Halle
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
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

function usage {
    echo "Usage: $0 -[iuvy]"
    echo
    echo "Options:"
    echo "  -i    create symlinks"
    echo "  -u    delete symlinks"
    echo "  -v    verbose output"
    echo "  -y    install YouCompleteMe vim plugin"
}

function symlink {
    if [ ! -e $2 ]; then
        ln -rs $1 $2
    else
        echo "Did not create symlink $2 because file exists."
    fi
}

function unsymlink {
    if [ -L $1 ]; then
        unlink $1
    else
        if [ -e $1 ]; then
            echo "Did not remove $1 because it is not a symlink."
        fi
    fi
}

function install {
    for i in "${!SYMLINKS[@]}"; do
    	symlink ${SOURCES[$i]} ${SYMLINKS[$i]}
    done
}

function uninstall {
    for i in "${!SYMLINKS[@]}"; do
        unsymlink ${SYMLINKS[$i]}
    done
}

if [[ $# -eq "$NO_ARGS" ]] # No arguments
then
    usage
    exit 0
fi

# Initialize submodules
git submodule update --recursive --init

while getopts ":iuvy" opt; do
    case $opt in
        v) set -x;;
        i) install;;
        u) uninstall;;
        y) (cd vim/bundle/YouCompleteMe\
            && ./install.sh --clang-completer --system-libclang);;
        *) echo "Invalid option: -$OPTARG" >&2; exit;;
    esac
done

exit 0

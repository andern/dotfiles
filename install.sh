#!/bin/bash

# Create symlinks
ln -rs vim ~/.vim
ln -rs vim/vimrc ~/.vimrc

# Initialize submodules
git submodule init
git submodule update

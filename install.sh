#!/bin/sh
OS=`uname`
VIM_RUNTIME=`pwd`

if [ ! -d $VIM_RUNTIME/bundle ]; then
    mkdir -p $VIM_RUNTIME/bundle
fi

if [ ! -e $VIM_RUNTIME/bundle/neobundle.vim ]; then
    echo "Installing Neobundle"
    git clone https://github.com/Shougo/neobundle.vim $VIM_RUNTIME/bundle/neobundle.vim
fi

rm -rf ~/.vimrc
echo "Removed ~/.vimrc"
rm -rf ~/.vim
echo "Removed ~/.vim"

ln -s $VIM_RUNTIME/vimrc ~/.vimrc
ln -s $VIM_RUNTIME ~/.vim
echo "link dotvim to ~/.vim"

vim +NeoBundleInstall +qall +y

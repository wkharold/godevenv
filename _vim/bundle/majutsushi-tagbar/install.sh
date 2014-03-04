#!/bin/bash -x

if [ -d "$HOME/.vim" ] && [ ! -L "$HOME/.vim" ]; then
  mv $HOME/.vim $HOME/.dotvim
fi

if [ ! -d "$HOME/.vim" ]; then
  ln -s $PWD/_vim $HOME/.vim
  /opt/go/src/github.com/nsf/gocode/vim/pathogen_update.sh
fi

if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
  mv $HOME/.vimrc $HOME/.dotvimrc
fi

if [ ! -f  "$HOME/.vimrc" ]; then
  ln -s $PWD/_vimrc $HOME/.vimrc
fi

git remote add -f jnwhiteh-vim-golang https://github.com/jnwhiteh/vim-golang.git
git subtree add --prefix _vim/bundle/vim-golang jnwhiteh-vim-golang master --squash

git remote add -f scrooloose-nerdtree https://github.com/scrooloose/nerdtree.git
git subtree add --prefix _vim/bundle/nerdtree scrooloose-nerdtree master --squash

git remote add -f majutsushi-tagbar https://github.com/majutsushi/tagbar.git
git subtree add --prefix _vim/bundle/majutsushi-tagbar master --squash

if [ -z "`which gotags`" ]; then
  go get -u github.com/jstemmer/gotags
fi

git subtree add --prefix supertab https://github.com/ervandew/supertab.git master --squash
mkdir -p $PWD/_vim/bundle/supertab/{doc,plugin}
ln -s $PWD/supertab/doc $PWD/_vim/bundle/supertab/doc
ln -s $PWD/supertab/doc $PWD/_vim/bundle/supertab/plugin

exit 0

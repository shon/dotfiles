which batcat || sudo apt-get install bat
which git || sudo apt-get install git
which vim || sudo apt-get install vim
which ctags || sudo apt-get install exuberant-ctags

grep 'bash_aliases' ~/.bashrc || echo "source ~/.bash_aliases" >> ~/.bashrc
ln -sf `pwd`/.bash_aliases ~/.bash_aliases
ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.gitconfig ~/.gitconfig
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

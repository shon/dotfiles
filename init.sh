sudo apt-get install exuberant-ctags git

echo "source .bash_aliases" >> ~/.bashrc
ln -sf `pwd`/.bash_aliases ~/.bash_aliases
ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.vim ~/.vim

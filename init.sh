(which git && which ctags) || sudo apt-get install vim exuberant-ctags git

grep 'bash_aliases' ~/.bashrc || echo "source ~/.bash_aliases" >> ~/.bashrc
ln -sf `pwd`/.bash_aliases ~/.bash_aliases
ln -sf `pwd`/.vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

sudo pip install git+https://github.com/chrisallenlane/cheat.git
sudo pip install git+https://github.com/gleitz/howdoi.git#egg=howdoi

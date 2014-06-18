# linux-home

## install

    curl -L https://gist.github.com/alaafterain/df16565031c5ba552a6c/raw/a79e957d9979c637fdbf8607105633653f07eee7/ar-home.sh | sh

## manually

- rvm[ruby-1.9.3]

  rvm install 1.9.3

  gem sources --remove https://rubygems.org/

  gem sources -a http://ruby.taobao.org/

- tmuxinator

  export EDITOR='vim' && gem install tmuxinator

- truecrypt

- vagrant

- vim[YouCompleteMe]

  cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer

- vim[BundleInstall]

    vim +BundleInstall +qa

- zsh

  chsh -s `which zsh`

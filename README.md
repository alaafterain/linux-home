# linux-home

## install

    git: https://github.com/alaafterain/linux-home/.ar_scripts/ar-home.sh

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

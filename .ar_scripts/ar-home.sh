set -e

echo "\033[0;32mapt sources[mirrors.163.com]\033[0m"
sudo sed -i 's/archive.ubuntu.com/mirrors.163.com/' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirrors.163.com/' /etc/apt/sources.list


echo "\033[0;32minstall git\033[0m"
sudo apt-get install git

echo "\033[0;32minstall ar-home\033[0m"
if [ ! -d "$HOME/linux-home" ]; then
    git clone https://github.com/alaafterain/linux-home $HOME/linux-home
    cp $HOME/linux-home/* $HOME/ -dpr
    find $HOME/linux-home/ -maxdepth 1 | grep -v -P "/$" | xargs -i cp {} $HOME/ -dpr
fi

echo "\033[0;32minstall rvm\033[0m"
sudo apt-get install build-essential
curl -sSL https://get.rvm.io | bash -s stable
source ~/.bashrc
sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' $HOME/.rvm/config/db

packages=$packages' alsa-utils'
packages=$packages' autojump'
packages=$packages' axel'
packages=$packages' curl'
packages=$packages' evince'
packages=$packages' fcitx'
packages=$packages' fcitx-googlepinyin'
packages=$packages' fluxbox'
packages=$packages' gimp'
packages=$packages' launchy'
packages=$packages' mlterm'
packages=$packages' mercurial'
packages=$packages' nginx'
packages=$packages' shutter'
packages=$packages' sdcv'
packages=$packages' tmux'
packages=$packages' tree'
packages=$packages' vim'
packages=$packages' w3m'
packages=$packages' xscreensaver'
packages=$packages' zsh'
echo "\033[0;32minstall packages:${packages}\033[0m"
sudo apt-get -y install $packages

echo "\033[0;32mconfigure...\033[0m"

echo "\033[0;32mbashrc\033[0m"
set +e
grep .bashrc_ar $HOME/.bashrc
if [ $? -ne 0 ]; then
    echo "source ~/.bashrc_ar" >> $HOME/.bashrc
fi
set -e

echo "\033[0;32mstardict\033[0m"
if [ ! -d "$HOME/.stardict/dic" ]; then
    mkdir -p $HOME/.stardict/dic
    curl http://abloz.com/huzheng/stardict-dic/zh_CN/stardict-langdao-ec-gb-2.4.2.tar.bz2 -o $HOME/.stardict/dic/stardict-langdao-ec-gb-2.4.2.tar.bz2
    tar jxf $HOME/.stardict/dic/stardict-langdao-ec-gb-2.4.2.tar.bz2 -C $HOME/.stardict/dic
    curl http://abloz.com/huzheng/stardict-dic/zh_CN/stardict-langdao-ce-gb-2.4.2.tar.bz2 -o $HOME/.stardict/dic/stardict-langdao-ce-gb-2.4.2.tar.bz2
    tar jxf $HOME/.stardict/dic/stardict-langdao-ce-gb-2.4.2.tar.bz2 -C $HOME/.stardict/dic
fi

echo "\033[0;32mtmux\033[0m"
export EDITOR='vim' && gem install tmuxinator

echo "\033[0;32mvim\033[0m"
if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "\033[0;32mzsh\033[0m"
#chsh -s `which zsh`
curl -L http://install.ohmyz.sh | sh

#vim +BundleInstall +qa
manual_packages=$manual_packages' truecrypt'
manual_packages=$manual_packages', vagrant'
manual_packages=$manual_packages', vim[YouCompleteMe], vim [BundleInstall]'
manual_packages=$manual_packages', rvm[ruby-1.9.3]'
echo "\033[0;32minstall $manual_packages manually\033[0m"

echo "\033[0;32msucessed!\033[0m"

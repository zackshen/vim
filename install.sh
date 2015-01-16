
OS=`uname`
VIM_RUNTIME=`pwd`

# Ubuntu 12.04
echo '
    deb http://mirrors.163.com/ubuntu/ precise main restricted
    deb-src http://mirrors.163.com/ubuntu/ precise main restricted
    deb http://mirrors.163.com/ubuntu/ precise-updates main restricted
    deb-src http://mirrors.163.com/ubuntu/ precise-updates main restricted
    deb http://mirrors.163.com/ubuntu/ precise universe
    deb-src http://mirrors.163.com/ubuntu/ precise universe
    deb http://mirrors.163.com/ubuntu/ precise-updates universe
    deb-src http://mirrors.163.com/ubuntu/ precise-updates universe
    deb http://mirrors.163.com/ubuntu/ precise multiverse
    deb-src http://mirrors.163.com/ubuntu/ precise multiverse
    deb http://mirrors.163.com/ubuntu/ precise-updates multiverse
    deb-src http://mirrors.163.com/ubuntu/ precise-updates multiverse
    deb http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ precise-security main restricted
    deb-src http://mirrors.163.com/ubuntu/ precise-security main restricted
    deb http://mirrors.163.com/ubuntu/ precise-security universe
    deb-src http://mirrors.163.com/ubuntu/ precise-security universe
    deb http://mirrors.163.com/ubuntu/ precise-security multiverse
    deb-src http://mirrors.163.com/ubuntu/ precise-security multiverse
' > /etc/apt/sources.list

sudo apt-get install -y git-core 
sudo apt-get install -y build-essential 
sudo apt-get install -y cmake automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
sudo apt-get install -y python-dev

# the_siliver_searcher
# mkdir -p ./build && cd ./build && git clone https://github.com/ggreer/the_silver_searcher && ./build.sh && sudo make install

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

rm -rf $VIM_RUNTIME/build

#! /usr/bin/env bash

# Install Xcode command line tools
xcode-select --install

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Java 8
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8

# Install brew-able packages
brew install fzf wget hub the_silver_searcher tmux pandoc node jq
brew install tree xsv ripgrep rclone pv micro watchman cocoapods coreutils yarn
brew install exiftool chrome-cli gpsbabel bat gifski
brew install react-native-cli direnv shellcheck

# Note that very many binary packages are available through brew casks
brew cask install openrct2 qgis slack spotify spotify-notifications chromedriver
brew cask install google-chrome selfcontrol
brew cask install google-earth-pro firefox xquartz virtualbox osxfuse
brew cask install docker 
brew install docker-compose docker-machine docker-completion
brew cask install atom visual-studio-code iterm2 keybase
brew cask install mactex alacritty
brew cask install 1password 1password-cli
brew cask install postman josm caprine artpip 
brew cask install react-native-debugger reactotron

# Download my dotfiles
git clone https://github.com/kylebarron/dotfiles.git /tmp/dotfiles
cp /tmp/dotfiles/git/gitconfig_desktop ~/.gitconfig

# Download oh my tmux
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# Replace with own .tmux.conf.local
cp /tmp/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local

# Oh my zsh
git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# ZSH autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# ZSH syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Material shell theme
cp /tmp/dotfiles/zsh/materialshell.zsh-theme ~/.oh-my-zsh/themes/

# ZSHrc
cp /tmp/dotfiles/zsh/zshrc_desktop ~/.zshrc

# Anaconda
url="https://repo.continuum.io/archive/Anaconda3-2019.10-MacOSX-x86_64.sh"
wget $url -O /tmp/anaconda3.sh
bash /tmp/anaconda3.sh -b -p ~/local/anaconda3
export PATH=$HOME/local/anaconda3/bin:$PATH
# rm ~/local/anaconda3/bin/curl

# Atom config
mv /tmp/dotfiles/atom ~/.atom

# Miniconda
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda3.sh
# bash /tmp/miniconda3.sh -b -p ~/local/miniconda3
# ~/local/miniconda3/bin/conda update --all
# export PATH=$HOME/local/miniconda3/bin:$PATH

# Jupyter notebook server
jupyter notebook --generate-config
# TODO: Update commands for mac:
# sed -i "s@#c.NotebookApp.port = 8888@c.NotebookApp.port = 8888@g" ~/.jupyter/jupyter_notebook_config.py
# sed -i "s@#c.NotebookApp.open_browser = True@c.NotebookApp.open_browser = False@g" ~/.jupyter/jupyter_notebook_config.py

# Python packages
# Mkdocs
pip install mkdocs mkdocs-material

# yapf
pip install yapf
mkdir -p ~/.config/yapf/
cp /tmp/dotfiles/yapf/yapf.py ~/.config/yapf/style


### Utilities

if [[ $gtop = 'True' ]]; then
    if [[ $sudo = 'True' ]]; then
        sudo npm install -g gtop
    else
        npm install -g gtop
    fi
fi

if [[ $peek = 'True' ]]; then
    if [[ $sudo = 'True' ]]; then
        # https://github.com/phw/peek
        sudo add-apt-repository ppa:peek-developers/stable
        sudo apt update
        sudo apt install -y peek
    else
        sudo_not_installed+=$'- Peek\n'
    fi
fi

if [[ $speed-test = 'True' ]]; then
    if [[ $sudo = 'True' ]]; then
        sudo npm install -g speed-test
    else
        npm install -g speed-test
    fi
fi


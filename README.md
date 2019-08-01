install dotfiles

```
cd ~/
git clone git@github.com:danethurber/.dotfiles.git
ln -s .dotfiles/.zshrc .zshrc

vi .gitconfig

# add to gitconfig
[include]
  path = ~/.dotfiles/.gitconfig
```

install brew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

install zsh

```
brew install zsh
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

```
vi ~/.secrets
```

install current node and set as default

```
nvm install 10.11.0
nvm alias default 10.11.0
```

install additional application with brew casks

```
source install-from-cask.sh
```

## create a Notes folder for Notational Velocity

```
mkdir ~/Notes

```

## install/config tmux

```
brew install tmux
brew install reattach-to-user-namespace
brew install gawk

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```

- load up tmux and install plugins with prefix+I
- config iterm to use the color profile found in this repo

## install vim-plug

```

brew install python

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```

## install search utils

```
brew install ripgrep
brew install fd

```

## setup vim configuration

```

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/coc-settings.json ~/.vim/coc-settings.json

```

## install with plug

```

:PlugInstall

```

## install additional coc extensions

```

:CocInstall coc-emoji coc-jest coc-json coc-tsserver

```

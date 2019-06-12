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

## install vim-plug

```
brew install python

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## install fd

```
brew install fd
```

## setup vim configuration

```
ln -s ~/.dotfiles/.vimrc ~/.vimrc
```

## install with plug

```
:PlugInstall
```

## install COC extenions

```
:CocInstall coc-tsserver coc-json
```

## install hammerspoon and config

(hammerspoon)[http://www.hammerspoon.org/]

```
ln -s ~/.dotfiles/.hammerspoon/init.lua ~/.hammerspoon/init.lua
```

## Slack emojipack

install [emojipack](https://github.com/lambtron/emojipacks)

run the install

`emojipacks -y https://github.com/danethurber/.dotfiles/emojipack/pack.yml`

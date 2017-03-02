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
brew install zsh zsh-completions
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

install nvm

```
brew install nvm
mkdir ~/.nvm
```

```
vi ~/.secrets
```

add nvm config to secrets file

```
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh
```

install current node and set as default

```
nvm install v7.6.0
nvm alias default 7.6.0
```

install additional application with brew casks

```
source install-from-cask.sh
```

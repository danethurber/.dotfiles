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

## Slack emojipack

install [emojipack](https://github.com/lambtron/emojipacks)

run the install

`emojipacks -y https://github.com/danethurber/.dotfiles/emojipack/pack.yml`

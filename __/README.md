install dotfiles

```
cd ~/
git clone git@github.com:danethurber/.dotfiles.git
ln -s .dotfiles/.zshrc .zshrc
ln -s .dotfiles/.psqlrc .psqlrc

vi .gitconfig

# add to gitconfig
[include]
  path = ~/.dotfiles/.gitconfig
```

bootstrap


```bash
./bootstrap.sh
```

config zsh

```
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```

## config tmux

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```

- load up tmux and install plugins with prefix+I
- config iterm to use the color profile found in this repo

create local secrets files

```
vi ~/.secrets
```

install current node and set as default

```
nvm install 15.3.0
nvm alias default 15.3.0
```

## install vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

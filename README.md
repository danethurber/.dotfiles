
## Installation Guide

clone the repo

```
cd ~/
git clone git@github.com:danethurber/.dotfiles.git
```

run the bootstrap command

```bash
./bootstrap.sh
```

config tmux

- load up tmux and install plugins with prefix+I
- config iterm to use the color profile found in this repo

install current node and set as default

```
nvm install node
```

install vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

install vim plugins with plug

```
:PlugInstall
```

install additional coc extensions

```
:CocInstall coc-emoji coc-jest coc-json coc-tsserver
```

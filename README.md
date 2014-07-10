```
cd ~/
git clone git@github.com:danethurber/.dotfiles.git .dotfiles
ln -s .dotfiles/.zshrc .zshrc

vi .gitconfig

# add to gitconfig
[include]
  path = ~/.dotfiles/.gitconfig
```

ln -s $PWD/.zshrc $HOME/.zshrc
mkdir -p ~/bin

echo "Installing antigen"
curl -L git.io/antigen > ~/bin/antigen.zsh

chmod +x ~/bin/antigen.zsh


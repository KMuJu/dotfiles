
# check if ~/.config/zsh/plugins exists
if [ ! -d "$HOME/.config/zsh/plugins" ]; then
    echo "Creating a .config/zsh/plugins folder in $HOME"
    echo "This can be copied elsewhere and then linked, preferrably using GNU stow"
    mkdir $HOME/.config/zsh/plugins
fi

# check if p10k exists
if [ ! -d "$HOME/.config/zsh/plugins/powerlevel10k" ]; then
    echo "Installing powerelevel10k theme."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.config/zsh/plugins/powerlevel10k
fi

source $HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# check if zsh autosuggest exists
if [ ! -d "$HOME/.config/zsh/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh autosuggestions."
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/plugins/zsh-autosuggestions
fi

source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# check if zsh syntax highlighting exists
if [ ! -d "$HOME/.config/zsh/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh syntax highlighting."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/zsh/plugins/zsh-syntax-highlighting
fi

source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# check if zsh history substring search
if [ ! -d "$HOME/.config/zsh/plugins/zsh-history-substring-search" ]; then
    echo "Installing zsh history substring search."
    git clone https://github.com/zsh-users/zsh-history-substring-search.git $HOME/.config/zsh/plugins/zsh-history-substring-search
fi

source $HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# enabling up and down arrow keys to use the plugin
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

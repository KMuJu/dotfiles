# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Sourcing the different plugins I have in zsh
source $HOME/.config/zsh/plugins.zsh

autoload -Uz compinit
compinit

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# https://github.com/KulkarniKaustubh/dotfiles/blob/main/zsh/.zshrc
# Fixing zsh history problems on multiple terminals
setopt inc_append_history
setopt share_history

# Fixing some keys inside zsh
autoload -Uz select-word-style
select-word-style bash

# Get bash's compgen
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Add highlight enabled tab completion with colors
zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# add binaries to $PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/cuda/bin
export PATH=$PATH:/usr/local/cuda/bin:/opt/cuda/bin
export PATH=$PATH:$HOME/.local/bin
# end of $PATH exports

source ~/.config/zsh/env.zsh
source ~/.config/zsh/alias.zsh
# source ~/.config/zsh/git.plugin.zsh

bindkey -s "^O" "$HOME/.local/scripts/tmux-sessionizer\n"
bindkey -s "^N" "$HOME/.local/scripts/tmux-sessionizer ~/.config/nvim\n"
bindkey -s "^K" ". $HOME/.local/scripts/skole\n"

bindkey '^[[Z' reverse-menu-complete

# custom ZSH keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward
# Ensure up/down arrows search history based on input AND move cursor to the end
autoload -U up-line-or-search
autoload -U down-line-or-search

# Bind Up Arrow to history search (moves cursor to end)
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search


# bash's command not found auto suggest
command_not_found_handler () {
    if [ -x /usr/lib/command-not-found ]
    then
        /usr/lib/command-not-found -- "$1"
        return $?
    else
        if [ -x /usr/share/command-not-found/command-not-found ]
        then
            /usr/share/command-not-found/command-not-found -- "$1"
            return $?
        else
            printf "%s: command not found\n" "$1" >&2
            return 127
        fi
    fi
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/home/Kasper/.bun/_bun" ] && source "/home/Kasper/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi

if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# opam configuration
[[ ! -r /home/Kasper/.opam/opam-init/init.zsh ]] || source /home/Kasper/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

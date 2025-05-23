alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias l='ls -lF'
alias lh='ls -lh'
alias lS='ls -1FS'
alias lt='ls -lt'
alias lr='ls -tr'
alias ld='ls -ld'
alias lA='ls -lA'
alias llh='ls -lh'
# alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo'
function mkcd(){ mkdir -p "$1"; cd "$1" };
alias grep='grep --color=auto'
function mu(){
    RES=$( udisksctl mount -b /dev/$1 | grep -oP '(?<=at )(.*)(?=\.)?' )
    echo "Mounted /dev/$1 at $RES"
    (cd $RES && exec zsh)
    udisksctl unmount -b /dev/$1
}

alias vim="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


alias cpp="cd ~/Koding/cpp"
alias i3conf="cd ~/.config/i3; nvim config"
alias polybarconf="cd ~/.config/polybar; nvim config.ini"
# alias obsidian="cd ~/NTNU/h23/Obsidian/H23"
alias nvimconf="cd ~/.config/nvim/;nvim"
alias conkyS="cd ~/.config/conky/; ./launch.sh open Storage"
alias pacman-fzf-remote="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias pacman-fzf-local="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# Studass
alias itgk="cd ~/NTNU/Studass/TDT4110"
alias objekt="cd ~/NTNU/Studass/TDT4100"

# Fag
alias matte4="cd ~/NTNU/h23/TMA4135"
alias algdat="cd ~/NTNU/h23/TDT4120"
alias statistikk="cd ~/NTNU/v24/TMA4245/"
alias ade="cd ~/NTNU/v24/TTT4203/"
alias bs="cd ~/NTNU/v24/Exphil/"
alias database="cd ~/NTNU/v24/TDT4145/"
alias introml="cd ~/NTNU/h24/TDT4172/"
alias datamaskin="cd ~/NTNU/h24/TDT4160/"
alias indec="cd ~/NTNU/h24/IMT4204/"

# Git
alias gs="git status"

# Monitor
alias monitor=". ~/.local/scripts/add_left.sh"

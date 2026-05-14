if [[ -f $1 ]]; then
    path=`realpath "$1"`
    hyprctl hyprpaper preload "$path"
    hyprctl hyprpaper wallpaper ",$path"
elif [[ -z $1 ]]; then
    ls ~/Bilder/Backgrounds/dark/
else
    echo "$1 is not a file"
fi

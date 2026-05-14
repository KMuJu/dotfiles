if [[ -z "$1" ]]; then
    path="$HOME/Bilder/Backgrounds"
elif [[ -d $1 ]]; then
    path=$1
fi
files=$(cd $path;fd --type f --strip-cwd-prefix 2> /dev/null)

file=$(printf "%s\n" "$files" | fzf)
if [ -z "$file" ]; then
    echo "No file selected"
    exit 0
fi

echo "Selected file $file"

~/.config/hypr/scripts/change_wallpaper.sh "$path/${file}"

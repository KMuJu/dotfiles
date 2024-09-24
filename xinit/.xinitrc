#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.config/xmodmap/keykodes
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
    echo "$usermodmap" > $HOME/usermodmap
fi

[[ -f ~/.config/xmodmap/keycodes ]] && xmodmap ~/.config/xmodmap/keycodes

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# xmodmap -e 'keycode 108 = Hyper_R'
# xmodmap -e 'add mod2 = Hyper_R'

exec i3

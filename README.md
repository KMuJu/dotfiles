# Usage
stow <folder you want to stow>

# Additional files

- /etc/udev/rules.d/99-hdmi-connect.rules
  - Udev rule to run a script when a hdmi cable is connected
  - Does not work

# Issues

## General usage
- [x] xidlehook will trigger even after locking with i3lock
- [x] xidlehook will trigger even when in fullscreen
- [ ] Automaticly detect hdmi cable and move current workspace over
- [ ] audio over hdmi
      if possible can start it when using the hdmi keybind
- [ ] cannot use alt-mappings in applications
      Should swap windows-key with alt and then change i3 to use windows-key
      This means that I can use the windows key for doing stuff with alt
- [ ] Map caps lock to be esc on tap and ctrl on hold

## Neovim
- [ ] Neotest for java does not work for some projects
- [ ] Rust analyzer does not give correct information
- [x] Markdown mapping for checking checkbox

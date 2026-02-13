# My Configs
- My Linux for Work (ML4W)
- custom hyprland config in progress...
- kitty: linux terminal emulator
- fastfetch: neofetch equivalent
- eza: `ls` command replacement
- ohmyposh: for a nice terminal prompt (starship equivalent)
- vimium: A browser extension for using vim motions in the browser
- Kanata: cross-platform software keyboard remapper
- halmak: A keyboard layout. check `halmak` folder. Original [repository](https://github.com/kaievns/halmak).
- npm global environment in user's home directory using `npm config set prefix '<path>'` [tutorial](https://github.com/sindresorhus/guides/blob/main/npm-global-without-sudo.md)
- wlogout: power menu
- waypaper for wallpapers


### GNU stow
- TODO: install GNU stow after system installation
- TODO: structure files like they should be in your home directory (~/)
- TODO: run `stow -t ~ .` (symlink this directory in ~ (target directory))

### Arduino IDE wayland fix
- install `arduino-ide.AppImage` from there website
- move `arduino-ide.AppImage` to `/opt/arduino-ide`
- there are two config files.
- copy each file to it's correct location and try to run the IDE
- if it runs wth no problems, create a shell script that automates the process
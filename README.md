I wanted a desktop shell for arch linux that doesn't take up too much resources and attention so I started this little project.
It was originally meant mostly as a learning experience but now I'm actually using it as a daily driver. The project is still early in development though.

The project was originally a part of [my dotfiles set up](https://github.com/UtriainenJ/dotfiles), but I moved this to its own repo for cleaner development. Original PR of the quickshell parts here: [#12](https://github.com/UtriainenJ/dotfiles/pull/12)

## Deps
- Quickshell
- Matugen
- Icons (whatever you choose, Papirus works well)
- Hyprland (not a hard deps; blurring is currently implemented only with Hyprland layerrules, see [hyprland layerrules in my dots](https://github.com/UtriainenJ/dotfiles/blob/05bbdf178707b457aa157036a0f619ec43dd36a1/dot_config/hypr/windowrules.conf#L36)

## Usage
Just clone the repo contents into `.config/quickshell` (or comparable if not following XDG Base Directory spec) and run `quickshell`
This can be done for example with:
1. `git clone https://github.com/UtriainenJ/oowsh.git`
3. `mkdir -p ~/.config/quickshell`
4. `mv oowsh/* ~/.config/quickshell`
5. `rm -rf oowsh/`

## Roadmap / TODO
- [x] Tray
- [ ] Notifications (currently WIP)
- [ ] Workspace management
- [ ] Calendar
- [x] Theming with matugen

## Screenshots
I'll add some when im not lazy

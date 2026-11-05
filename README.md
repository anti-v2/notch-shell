# Fedora + Hyprland notch-shell monochrome setup

This is a customisation overlay for the upstream `Kishan362/notch-shell`
repository, not a replacement shell. It adds a neutral monochrome palette,
sets up a floating pill, and supplies Hyprland bindings.

## Design
- Floating pill: `pillTopMargin: 16`, not flush with the top edge.
- Monochrome: near-black surfaces, white/grey text, grayscale accents/statuses.
- Pill modules: Wi-Fi, battery, volume, microphone, workspaces, clock.
- The upstream control centre, MPRIS player/album art, notifications, OSD,
  clipboard, wallpaper switcher, dashboard, launcher and power menu remain intact.

## Install
Extract the archive, open a terminal in this folder, and run:

```bash
./setup-fedora.sh
```

The helper installs Fedora dependencies, enables the Quickshell COPR, clones
the repository into `~/src/notch-shell`, patches its palette, and runs the
upstream installer with `--skip-deps`. That flag matters: upstream's dependency
installer uses Arch's `pacman`, so do not run it without the flag on Fedora.

The helper backs up `ThemePalettes.qml` before patching and saves any existing
user config before replacing it. It does not edit Hyprland automatically.

## Hyprland
Review `hyprland-bindings.conf`, check for key conflicts, then append the
needed lines to `~/.config/hypr/hyprland.conf`. Reload with `hyprctl reload`.
Test manually first using `notch-shell`. Keep only one `exec-once = notch-shell`.

## Notes
- The wallpaper directory is set to `~/pix`.
- Weather is set to Pune and calendar country to India.
- Font defaults are Monocraft and JetBrainsMono Nerd Font Propo; install them
  or change the font names in `~/.config/notch-shell/config.jsonc`.
- Optional upstream extras include `cava`, `awww`, ImageMagick and `wallust`.
- This shell is pinned to monochrome, so wallpaper changes do not recolour it.
  Kitty can follow wallpaper colours separately; this overlay intentionally
  does not replace your Kitty config or create a wallust template for it.

The upstream README says the project is tested on Arch and NixOS, not Fedora.
This is a Fedora-oriented adaptation, not an upstream-certified Fedora build.
The project is GPL-3.0; retain its licence and attribution when modifying it.

## Rollback
Remove the added Hyprland binds and `exec-once` line. Stop the shell with
`qs -p /usr/share/notch-shell kill`. Restore
`~/src/notch-shell/qml/ThemePalettes.qml.upstream.bak` if needed, then use
the upstream uninstall script from the checkout.

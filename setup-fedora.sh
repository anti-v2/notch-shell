#!/usr/bin/env bash
set -euo pipefail
if [[ ! -r /etc/fedora-release ]]; then
  echo "This setup helper is intended for Fedora." >&2
  exit 1
fi
HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="${HOME}/src/notch-shell"

sudo dnf install -y git cmake gcc-c++ make \
  qt6-qtbase-devel qt6-qtdeclarative-devel qt6-qtmultimedia-devel \
  cliphist brightnessctl wl-clipboard inotify-tools \
  python3-psutil blueman pipewire lm_sensors NetworkManager

sudo dnf copr enable -y errornointernet/quickshell
sudo dnf install -y quickshell

if [[ ! -d "${REPO_DIR}/.git" ]]; then
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone --depth=1 https://github.com/Kishan362/notch-shell.git "$REPO_DIR"
else
  echo "Using existing checkout: $REPO_DIR"
fi

if [[ -f "$REPO_DIR/qml/ThemePalettes.qml" && ! -f "$REPO_DIR/qml/ThemePalettes.qml.upstream.bak" ]]; then
  cp -a "$REPO_DIR/qml/ThemePalettes.qml" "$REPO_DIR/qml/ThemePalettes.qml.upstream.bak"
fi
python3 "$HERE/scripts/add-monochrome-theme.py" "$REPO_DIR/qml/ThemePalettes.qml"

cd "$REPO_DIR"
sudo ./install.sh --skip-deps

mkdir -p "$HOME/.config/notch-shell"
if [[ -f "$HOME/.config/notch-shell/config.jsonc" ]]; then
  cp -a "$HOME/.config/notch-shell/config.jsonc" \
    "$HOME/.config/notch-shell/config.jsonc.before-monochrome.$(date +%Y%m%d-%H%M%S)"
fi
install -m 0644 "$HERE/config/config.jsonc" "$HOME/.config/notch-shell/config.jsonc"

echo
echo "Installed notch-shell with the monochrome palette."
echo "Test it with: notch-shell"
echo "Add the provided Hyprland bindings and exec-once line from README.md."

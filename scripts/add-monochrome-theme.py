#!/usr/bin/env python3
from pathlib import Path
import sys

path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("qml/ThemePalettes.qml")
if not path.is_file():
    raise SystemExit(f"Cannot find {path}. Run this from the notch-shell checkout.")
source = path.read_text()
if '"monochrome": {' in source:
    print("Monochrome palette already exists; leaving it unchanged.")
    raise SystemExit(0)
marker = '        "default": {'
if marker not in source:
    raise SystemExit('Could not find the "default" palette insertion point; no file was changed.')

block = """        // --------------------------------------------------------- monochrome
        "monochrome": {
            label: "Monochrome",
            light: false,
            swatches: ["#050505", "#171717", "#a8a8a8", "#f5f5f5"],
            palette: {
                base: "#050505",
                raised: "#111111",
                high: "#202020",
                text: "#f5f5f5",
                muted: "#c7c7c7",
                faint: "#777777",
                accent: "#d8d8d8",
                warning: "#bdbdbd",
                danger: "#f0f0f0",
                glow: "#bdbdbd",
                ok: "#cfcfcf",
                info: "#bdbdbd"
            }
        },
"""
path.write_text(source.replace(marker, block + marker, 1))
print(f"Added monochrome palette to {path}")

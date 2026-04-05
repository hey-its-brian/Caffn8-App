# Caffn8 ☕

A lightweight macOS menu bar app that keeps your Mac and display awake using the built-in `caffeinate` command.

## Features

- Lives in the menu bar — no Dock icon
- Preset durations: 30 minutes, 1 hour, 2 hours, 4 hours
- Custom duration input (in hours)
- Indefinite mode
- Live countdown timer displayed in the menu bar
- Clean stop at any time

## Requirements

- macOS 14.0 or later
- Xcode 15 or later (to build from source)

## Installation

Clone the repo and open `Caffn8.xcodeproj` in Xcode, then build and run.
```bash
git clone https://github.com/hey-its-brian/caffn8-app.git
cd caffn8-app
open Caffn8.xcodeproj
```

## How It Works

Caffn8 runs macOS's built-in `caffeinate` command in the background with the following flags:

| Flag | Effect |
|------|--------|
| `-d` | Prevents display sleep |
| `-i` | Prevents system idle sleep |
| `-t` | Sets a time limit in seconds (timed sessions only) |

The process is automatically terminated when the timer expires or you click Stop.

## Built With

- Swift
- SwiftUI
- AppKit

## License

MIT

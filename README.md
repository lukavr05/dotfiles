#  Personal Linux Dotfiles

A curated collection of configuration files for a minimal, productive, and aesthetically pleasing Linux desktop environment built around BSPWM.

##  Overview

This dotfiles setup creates a cohesive tiling window manager environment with:
- **Window Manager**: BSPWM with custom keybindings
- **Status Bar**: Polybar with weather, music, and system monitoring
- **Terminal**: Kitty with Gruvbox theme
- **Editor**: Neovim (NvChad configuration)
- **Compositor**: Picom for smooth animations and transparency
- **Application Launcher**: Rofi with gruvbox theme
- **System Info**: Neofetch custom configuration

##  Structure

```
dotfiles/
├── bspwm/           # Window manager configuration
├── sxhkd/           # Key bindings for BSPWM
├── polybar/         # Status bar with custom scripts
│   ├── scripts/
│   │   ├── bluetooth/     # Bluetooth controls
│   │   ├── now-playing/   # Music display
│   │   └── weather/       # Weather widget
├── kitty/           # Terminal emulator
│   ├── appearance.conf   # Gruvbox theme
│   ├── fonts.conf        # Font settings
│   └── keybindings.conf  # Terminal shortcuts
├── picom/           # Compositor for effects
├── rofi/            # Application launcher
├── neofetch/        # System info display
└── nvim/            # Neovim configuration (NvChad)
```

##  Key Features

### BSPWM Configuration
- 10 workspaces with Roman numerals
- Custom border colors (focused: `#8ec07c`, normal: `#444444`)
- 6px window gaps, 2px borders
- Autostart applications (picom, polybar, nm-applet, etc.)
- Caps Lock mapped to Escape

### Polybar Status Bar
- Custom Gruvbox color scheme
- Weather widget with auto-location detection
- Now playing indicator for media
- Bluetooth connectivity status
- System update notifications
- Custom modules for CPU, memory, and volume

### Kitty Terminal
- Gruvbox-inspired color palette
- 82% background opacity
- Custom font configuration
- Smooth scrolling and block cursor

### Neovim (NvChad)
- Modern Neovim configuration based on NvChad v2.5
- Lazy.nvim plugin manager
- LSP, Mason, Telescope integration
- Custom keybindings and highlights

### Keybindings (SXHKD)
- `Super + Space`: Rofi application launcher
- `Super + {t,f,o,c,e}`: Launch terminal, browser, obsidian, editor, file manager
- `Super + Escape`: Reload SXHKD
- `Super + Alt + Q`: Power menu

##  Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Create symbolic links**
   ```bash
   # BSPWM
   ln -sf ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
   chmod +x ~/.config/bspwm/bspwmrc
   
   # SXHKD
   ln -sf ~/.dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
   
   # Polybar
   ln -sf ~/.dotfiles/polybar ~/.config/polybar
   
   # Kitty
   ln -sf ~/.dotfiles/kitty ~/.config/kitty
   
   # Picom
   ln -sf ~/.dotfiles/picom/picom.conf ~/.config/picom/picom.conf
   
   # Rofi
   ln -sf ~/.dotfiles/rofi ~/.config/rofi
   
   # Neovim
   ln -sf ~/.dotfiles/nvim ~/.config/nvim
   
   # Neofetch
   ln -sf ~/.dotfiles/neofetch ~/.config/neofetch
   ```

3. **Install dependencies**
   ```bash
   # Ubuntu/Debian
   sudo apt install bspwm sxhkd polybar kitty picom rofi neofetch
   
   # Arch Linux
   sudo pacman -S bspwm sxhkd polybar kitty picom rofi neofetch
   ```

4. **Set up scripts**
   ```bash
   chmod +x ~/.config/polybar/scripts/*.sh
   chmod +x ~/.config/polybar/scripts/*/*.sh
   ```

##  Customization

### Colors
The setup uses a consistent Gruvbox color palette:
- Background: `#282828` (dark), `#32302f` (kitty)
- Foreground: `#ebdbb2`
- Accent colors: `#8ec07c` (green), `#d79921` (yellow), `#458588` (blue)

### Fonts
- Terminal: Configured in `kitty/fonts.conf`
- Status bar: Configured in `polybar/config.ini`

### Polybar Modules
Add or remove modules in `polybar/config.ini`:
- Weather: Requires API key setup
- Bluetooth: Uses `bluetooth.sh` script
- Music: Integrates with MPRIS players

##  Requirements

- **Display Server**: X11 (not Wayland compatible)
- **Shell**: Zsh (configured in kitty)
- **Cursor Theme**: WinSur Dark Cursors (set in bspwmrc)
- **Additional Tools**: nitrogen (wallpaper), dunst (notifications)

##  Troubleshooting

- **Polybar not starting**: Check script permissions and dependencies
- **Weather not working**: Set up API key in weather scripts
- **Neovim plugins**: Run `:Lazy` to install missing plugins
- **Keybindings not working**: Restart SXHKD with `Super + Escape`

##  Preview

*(Add screenshots of your setup here)*

##  Contributing

Feel free to fork, modify, and submit pull requests. This is a personal configuration, but suggestions for improvements are welcome!

##  License

This configuration is provided as-is. Feel free to use and modify it for your own setup.

---

**Note**: Backup your existing configurations before installing these dotfiles. Some configurations may require additional setup depending on your system and preferences.
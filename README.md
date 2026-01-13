#  Personal Linux Dotfiles

A curated collection of configuration files for a minimal, productive, and aesthetically pleasing Linux desktop environment built around BSPWM.

##  Overview

This dotfiles setup creates a cohesive tiling window manager environment with:
- **Display Manager**: Ly with custom Gruvbox-inspired theming
- **Window Manager**: BSPWM with custom keybindings
- **Status Bar**: Polybar with weather, music, and system monitoring
- **Terminal**: Kitty with Gruvbox theme
- **Editor**: Neovim with modern NvChad v2.5 configuration
- **Compositor**: Picom for smooth animations and transparency
- **Application Launcher**: Rofi with gruvbox theme
- **System Info**: Fastfetch with custom configuration

##  Structure

```
dotfiles/
├── ly/              # Display manager configuration
│   └── config.ini       # Gruvbox-themed login screen
├── bspwm/           # Window manager configuration
├── sxhkd/           # Key bindings for BSPWM
├── polybar/         # Status bar with custom scripts
│   ├── scripts/
│   │   ├── bluetooth/     # Bluetooth controls
│   │   ├── now-playing/   # Music display
│   │   ├── weather/       # Weather widget
│   │   └── check_updates.sh # System update monitoring
├── kitty/           # Terminal emulator
│   ├── appearance.conf   # Gruvbox theme
│   ├── fonts.conf        # Font settings
│   └── keybindings.conf  # Terminal shortcuts
├── picom/           # Compositor for effects
├── rofi/            # Application launcher
├── fastfetch/       # System info display with custom config
└── nvim/            # Neovim configuration (NvChad v2.5)
    ├── lua/configs/     # Plugin configurations
    │   ├── snacks.lua   # Dashboard and UI enhancements
    │   ├── noice.lua    # LSP UI improvements
    │   ├── conform.lua  # Code formatting
    │   ├── oil.lua      # File explorer
    │   └── ...          # Other configurations
    └── ...
```

##  Installation

1. **Clone and install**
   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ./install.sh
   ```

   *Or manually:*

2. **Create symbolic links**
   ```bash
   ln -sf ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc && chmod +x ~/.config/bspwm/bspwmrc
   ln -sf ~/.dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
   ln -sf ~/.dotfiles/{polybar,kitty,rofi,nvim,fastfetch} ~/.config/
   ln -sf ~/.dotfiles/picom/picom.conf ~/.config/picom/picom.conf
   sudo ln -sf ~/.dotfiles/ly/config.ini /etc/ly/config.ini
   chmod +x ~/.config/polybar/scripts/*.sh ~/.config/polybar/scripts/*/*.sh
   ```

3. **Install dependencies**
   ```bash
   # Ubuntu/Debian
   sudo apt install bspwm sxhkd polybar kitty picom rofi fastfetch ly
   
   # Arch Linux
   sudo pacman -S bspwm sxhkd polybar kitty picom rofi fastfetch ly
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
- **Additional Tools**: nitrogen (wallpaper), dunst (notifications), fortune (for Neovim dashboard)
- **Python Dependencies**: Required for Polybar now-playing module
- **Code Formatters**: stylua, prettier, clang-format, gofumpt (for Neovim formatting)
- **Display Manager**: Ly (alternative to SDDM/GDM with TTY interface)
- **Brightness Control**: brightnessctl (for Ly brightness hotkeys)





##  Preview

*(Add screenshots of your setup here)*

##  Contributing

Feel free to fork, modify, and submit pull requests. This is a personal configuration, but suggestions for improvements are welcome!

##  License

This configuration is provided as-is. Feel free to use and modify it for your own setup.

---

**Note**: Backup your existing configurations before installing these dotfiles. Some configurations may require additional setup depending on your system and preferences.
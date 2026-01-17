#  Personal Linux Dotfiles

A curated collection of configuration files for a minimal, productive, and aesthetically pleasing Linux desktop environment built around BSPWM.

##  Overview

This dotfiles setup creates a cohesive tiling window manager environment with:
- **Display Manager**: Ly with custom Gruvbox-inspired theming
- **Window Manager**: BSPWM with custom keybindings
- **Status Bar**: Polybar with weather, music, bluetooth, and system monitoring
- **Terminal**: Kitty with Gruvbox theme and custom keybindings
- **Editor**: Neovim with modern NvChad v2.5 configuration
- **Compositor**: Picom for smooth animations and transparency
- **Application Launcher**: Rofi with multiple themes and applets
- **Notifications**: Dunst with customized styling
- **File Manager**: PCManFM with default configuration
- **System Info**: Fastfetch with custom configuration
- **Custom Scripts**: Brightness control and workspace management

##  Structure

```
dotfiles/
├── ly/              # Display manager configuration
│   └── config.ini       # Gruvbox-themed login screen
├── bspwm/           # Window manager configuration
├── sxhkd/           # Key bindings for BSPWM
├── polybar/         # Status bar with custom scripts
│   ├── scripts/
│   │   ├── bluetooth/     # Bluetooth controls and toggle
│   │   │   ├── bluetooth.sh
│   │   │   └── toggle_bluetooth.sh
│   │   ├── now-playing/   # Music display with MPRIS support
│   │   │   └── polybar-now-playing.py
│   │   ├── weather/       # Weather widget with forecast and auto-location
│   │   │   ├── weather.sh
│   │   │   ├── weather-forecast.sh
│   │   │   ├── smart-weather.sh
│   │   │   ├── auto-location.sh
│   │   │   ├── toggle-weather.sh
│   │   │   ├── city-manager.sh
│   │   │   ├── cities.conf
│   │   │   └── current_city
│   │   ├── check_updates.sh # System update monitoring
│   │   └── netspeed.sh    # Network speed monitoring
├── kitty/           # Terminal emulator
│   ├── appearance.conf   # Gruvbox theme
│   ├── fonts.conf        # Font settings
│   ├── keybindings.conf  # Terminal shortcuts
│   └── kitty.conf        # Main terminal configuration
├── picom/           # Compositor for effects
│   └── picom.conf        # Animation and transparency settings
├── rofi/            # Application launcher with extensive theming
│   ├── colors/           # 17 color themes (gruvbox, catppuccin, dracula, etc.)
│   ├── launchers/        # 7 launcher types with shared components
│   ├── powermenu/        # Power menu with 6 different types
│   │   ├── type-1/ through type-6/
│   ├── applets/          # System applets (5 types + shared/bin)
│   ├── images/           # Background images for themes
│   └── scripts/          # Custom launcher scripts
├── dunst/           # Notification daemon
│   ├── dunstrc           # Main notification configuration
│   └── scripts/
│       └── default_script.sh
├── pcmanfm/         # File manager configuration
│   └── default/pcmanfm.conf # File manager settings
├── fastfetch/       # System info display with custom config
│   └── config.jsonc     # Fastfetch configuration
├── scripts/         # Custom utility scripts
│   ├── smooth-brightness.sh # Smooth brightness transitions
│   └── rofi-workspaces.sh   # Workspace switcher for BSPWM
└── nvim/            # Neovim configuration (NvChad v2.5)
    ├── lua/configs/     # Plugin configurations
    │   ├── snacks.lua   # Dashboard and UI enhancements
    │   ├── noice.lua    # LSP UI improvements
    │   ├── conform.lua  # Code formatting
    │   ├── oil.lua      # File explorer
    │   ├── telescope.lua # Fuzzy finder
    │   ├── lspconfig.lua # LSP configuration
    │   ├── mason.lua    # LSP package manager
    │   └── lazy.lua     # Plugin manager configuration
    └── ...
```

##  Installation

1. **Clone the repository**
    ```bash
    git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ```

    *Install manually:*

2. **Create symbolic links**
   ```bash
   ln -sf ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc && chmod +x ~/.config/bspwm/bspwmrc
   ln -sf ~/.dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
   ln -sf ~/.dotfiles/{polybar,kitty,rofi,nvim,fastfetch,dunst,pcmanfm} ~/.config/
   ln -sf ~/.dotfiles/picom/picom.conf ~/.config/picom/picom.conf
   sudo ln -sf ~/.dotfiles/ly/config.ini /etc/ly/config.ini
   chmod +x ~/.config/polybar/scripts/*.sh ~/.config/polybar/scripts/*/*.sh
   chmod +x ~/.config/scripts/*.sh
   ```

3. **Install dependencies**
   ```bash
   # Ubuntu/Debian
   sudo apt install bspwm sxhkd polybar kitty picom rofi fastfetch ly dunst pcmanfm bc
   
   # Arch Linux
   sudo pacman -S bspwm sxhkd polybar kitty picom rofi fastfetch ly dunst pcmanfm bc
   ```

##  Customization

### Colors
The setup uses a consistent Gruvbox color palette:
- Background: `#282828` (dark), `#32302f` (kitty)
- Foreground: `#ebdbb2`
- Accent colors: `#8ec07c` (green), `#d79921` (yellow), `#458588` (blue)

### Fonts
- Terminal: Configured in `kitty/fonts.conf` and `kitty/kitty.conf`
- Status bar: Configured in `polybar/config.ini`
- Notifications: Configured in `dunst/dunstrc`

### Polybar Modules
Add or remove modules in `polybar/config.ini`:
- Weather: Requires API key setup, includes forecast and auto-location
- Bluetooth: Uses `bluetooth.sh` script with toggle functionality
- Music: Integrates with MPRIS players via `polybar-now-playing.py`
- Network Speed: Real-time network monitoring via `netspeed.sh`
- System Updates: Monitors available package updates

##  Requirements

- **Display Server**: X11 (not Wayland compatible)
- **Shell**: Zsh (configured in kitty)
- **Cursor Theme**: WinSur Dark Cursors (set in bspwmrc)
- **Additional Tools**: nitrogen (wallpaper), fortune (for Neovim dashboard)
- **Python Dependencies**: Required for Polybar now-playing module
- **Code Formatters**: stylua, prettier, clang-format, gofumpt (for Neovim formatting)
- **Display Manager**: Ly (alternative to SDDM/GDM with TTY interface)
- **Brightness Control**: brightnessctl (for smooth brightness transitions)
- **Math Utilities**: bc (required for smooth-brightness.sh script)
- **File Manager**: PCManFM (for graphical file management)
- **Notifications**: Dunst (for desktop notifications)





##  Preview

*(Add screenshots of your setup here)*

##  Contributing

Feel free to fork, modify, and submit pull requests. This is a personal configuration, but suggestions for improvements are welcome!

##  License

This configuration is provided as-is. Feel free to use and modify it for your own setup.

---

**Note**: Backup your existing configurations before installing these dotfiles. Some configurations may require additional setup depending on your system and preferences.
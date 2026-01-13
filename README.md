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

##  Key Features

### BSPWM Configuration
- 10 workspaces with Roman numerals
- Custom border colors (focused: `#8ec07c`, normal: `#444444`)
- 6px window gaps, 2px borders
- Autostart applications (picom, polybar, nm-applet, etc.)
- Caps Lock mapped to Escape

### Polybar Status Bar
- Custom Gruvbox color scheme
- Weather widget with auto-location detection and city management
- Now playing indicator for media with Python integration
- Bluetooth connectivity status with toggle controls
- System update notifications with package count monitoring
- Custom modules for CPU, memory, and volume
- Enhanced script organization with dedicated subdirectories

### Kitty Terminal
- Gruvbox-inspired color palette
- 82% background opacity
- Custom font configuration
- Smooth scrolling and block cursor

### Neovim (NvChad v2.5)
- Modern Neovim configuration with Lazy.nvim plugin manager
- **Snacks.nvim**: Enhanced dashboard with fortune quotes, file browser, and project management
- **Noice.nvim**: Improved LSP UI with custom cmdline and popupmenu styling
- **Conform.nvim**: Code formatting with language-specific formatters (stylua, prettier, clang-format, etc.)
- **Oil.nvim**: Advanced file explorer with preview, trash support, and LSP integration
- **Mason & LSP**: Complete language server protocol support
- **Telescope**: Fuzzy finding and navigation
- Custom keybindings and Gruvbox-inspired highlights

### Fastfetch
- Modern system information display replacing Neofetch
- Custom JSON configuration with icon-based module display
- Comprehensive system metrics (CPU, memory, disk, battery, packages)
- Color palette preview with customizable block symbols
- Optimized performance with threading and timeout settings
- Enhanced visual output with chafa logo support

### Ly Display Manager
- Custom Gruvbox-inspired color scheme with dark background (#1D2021)
- Animated color mixing background with seamless transitions
- Auto-login configuration for BSPWM session
- Battery status display and brightness control (F5/F6 keys)
- Power management shortcuts (F1: shutdown, F2: restart, F3: sleep, F4: hibernate)
- Big clock display with customizable time format
- Failed login authentication animation (triggers after 10 failed attempts)
- Session persistence with save/load functionality

### Keybindings (SXHKD)
- `Super + Space`: Rofi application launcher
- `Super + {t,f,o,c,e}`: Launch terminal, browser, obsidian, editor, file manager
- `Super + Escape`: Reload SXHKD
- `Super + Shift + Delete`: Power menu (logout/shutdown/restart)
- Updated keybinding structure to eliminate conflicts
- Caps Lock mapped to Escape for improved workflow

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
    
# Fastfetch
    ln -sf ~/.dotfiles/fastfetch ~/.config/fastfetch
    
    # Ly Display Manager (requires root)
    sudo ln -sf ~/.dotfiles/ly/config.ini /etc/ly/config.ini

3. **Install dependencies**
   ```bash
# Ubuntu/Debian
    sudo apt install bspwm sxhkd polybar kitty picom rofi fastfetch ly
    
    # Arch Linux
    sudo pacman -S bspwm sxhkd polybar kitty picom rofi fastfetch ly
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
- **Additional Tools**: nitrogen (wallpaper), dunst (notifications), fortune (for Neovim dashboard)
- **Python Dependencies**: Required for Polybar now-playing module
- **Code Formatters**: stylua, prettier, clang-format, gofumpt (for Neovim formatting)
- **Display Manager**: Ly (alternative to SDDM/GDM with TTY interface)
- **Brightness Control**: brightnessctl (for Ly brightness hotkeys)

##  Troubleshooting

- **Polybar not starting**: Check script permissions and Python dependencies
- **Weather not working**: Set up API key in weather scripts and check city configuration
- **Neovim plugins**: Run `:Lazy` to install missing plugins, ensure Mason formatters are installed
- **Fastfetch not displaying**: Check JSON configuration syntax and Nerd Font support
- **Ly not starting**: Check permissions and ensure Ly service is enabled (`systemctl enable ly`)
- **Ly configuration not applied**: Verify symlink to `/etc/ly/config.ini` and restart Ly service
- **Brightness controls not working**: Install brightnessctl and ensure proper permissions
- **Keybindings not working**: Restart SXHKD with `Super + Escape`
- **Code formatting not working**: Install required formatters (stylua, prettier, clang-format, gofumpt)

##  Recent Updates

### Major Changes (2025)
- **Replaced Neofetch with Fastfetch**: Modern system info tool with enhanced customization
- **Enhanced Neovim Configuration**: Added Snacks.nvim dashboard, Noice.nvim UI improvements, and Conform.nvim formatting
- **Updated Keybindings**: Replaced VSCode with Zed editor, resolved keybinding conflicts
- **Improved Polybar Scripts**: Better weather widget with city management, enhanced now-playing with Python
- **Code Formatting Setup**: Comprehensive formatter support for multiple languages

### New Features
- Advanced file explorer with Oil.nvim (preview, trash support, LSP integration)
- Enhanced dashboard with fortune quotes and project management
- Improved LSP UI with custom cmdline and popup styling
- System update monitoring with package count display
- Bluetooth toggle controls in Polybar

##  Preview

*(Add screenshots of your setup here)*

##  Contributing

Feel free to fork, modify, and submit pull requests. This is a personal configuration, but suggestions for improvements are welcome!

##  License

This configuration is provided as-is. Feel free to use and modify it for your own setup.

---

**Note**: Backup your existing configurations before installing these dotfiles. Some configurations may require additional setup depending on your system and preferences.
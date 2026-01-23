#  Personal Linux Dotfiles

A curated collection of configuration files for a minimal, productive, and aesthetically pleasing Linux desktop environment built around BSPWM.

##  Overview

This dotfiles setup creates a cohesive tiling window manager environment with:
- **Shell**: Zsh with Powerlevel10k theme, Oh My Zsh plugins, and comprehensive aliases
- **Display Manager**: Ly with custom Gruvbox-inspired theming
- **Window Manager**: BSPWM with custom keybindings and window rules
- **Key Daemon**: SXHKD with extensive keybindings for window management
- **Status Bar**: Polybar with weather, bluetooth, and system monitoring modules
- **Terminal**: Kitty with modular configuration (appearance, fonts, keybindings)
- **Editor**: Neovim with NvChad v2.5 and custom plugins
- **Compositor**: Picom for smooth animations and transparency
- **Application Launcher**: Rofi with 7 launcher types, 6 powermenu types, and 15+ color themes
- **Notifications**: Dunst with customized styling
- **File Manager**: PCManFM with default configuration
- **System Info**: Fastfetch with custom configuration

##  Structure

```
dotfiles/
├── .zshrc             # Zsh configuration with Oh My Zsh, aliases, and functions
├── .zshenv            # Zsh environment variables
├── bspwm/             # Window manager configuration
│   └── bspwmrc            # BSPWM startup script and rules
├── sxhkd/             # Key bindings for BSPWM
│   └── sxhkdrc            # Comprehensive keybinding configuration
├── polybar/           # Status bar with custom modules
│   ├── config.ini         # Main polybar configuration with Gruvbox theme
│   ├── launch.sh           # Polybar launcher script
│   └── scripts/
│       ├── bluetooth/         # Bluetooth controls
│       │   ├── bluetooth.sh
│       │   └── toggle_bluetooth.sh
│       ├── weather/           # Weather widget configuration
│       │   ├── weather.sh
│       │   ├── cities.conf
│       │   └── current_city
│       └── check_updates.sh   # System update monitoring
├── kitty/             # Terminal emulator with modular config
│   ├── kitty.conf         # Main terminal configuration
│   ├── appearance.conf    # Gruvbox theme settings
│   ├── fonts.conf         # Font configuration
│   └── keybindings.conf   # Terminal shortcuts
├── picom/             # Compositor for effects
│   └── picom.conf         # Animation and transparency settings
├── rofi/              # Application launcher with extensive theming
│   ├── config.rasi         # Global Rofi configuration
│   ├── colors/             # 15+ color themes (gruvbox, catppuccin, dracula, etc.)
│   ├── launchers/          # 7 launcher types (type-1 through type-7)
│   │   ├── type-1/         # Each with 15 style variations
│   │   ├── type-2/
│   │   ├── type-3/
│   │   ├── type-4/
│   │   ├── type-5/
│   │   ├── type-6/
│   │   └── type-7/
│   ├── powermenu/          # 6 power menu types
│   │   ├── type-1/         # Power menu with different styles
│   │   ├── type-2/
│   │   ├── type-3/
│   │   ├── type-4/
│   │   ├── type-5/
│   │   └── type-6/
│   ├── applets/            # System applets with shared themes
│   │   └── shared/
│   │       ├── colors.rasi
│   │       ├── fonts.rasi
│   │       └── theme.bash
│   ├── images/             # Background images for themes
│   └── scripts/            # Custom launcher and power menu scripts
├── dunst/             # Notification daemon
│   ├── dunstrc             # Main notification configuration
│   └── scripts/
│       └── default_script.sh
├── pcmanfm/           # File manager configuration
│   └── default/
│       └── pcmanfm.conf        # File manager settings
├── fastfetch/         # System info display
│   └── config.jsonc         # Fastfetch configuration
├── scripts/           # Custom utility scripts (currently empty)
└── nvim/              # Neovim configuration (NvChad v2.5)
    ├── init.lua            # Main Neovim configuration
    ├── lazy-lock.json      # Plugin lockfile
    ├── .stylua.toml        # Lua formatting configuration
    ├── README.md            # NvChad-specific documentation
    ├── lua/
    │   ├── options.lua         # Neovim options
    │   ├── mappings.lua        # General key mappings
    │   ├── highlights.lua      # Custom highlight groups
    │   ├── chadrc.lua          # Main NvChad configuration
    │   ├── configs/            # Plugin configurations
    │   │   └── snacks.lua      # Dashboard and UI enhancements
    │   ├── mappings/           # Specific mapping groups
    │   │   └── clipboard.lua   # Clipboard mappings
    │   └── plugins/            # Plugin specifications
    │       ├── init.lua         # Plugin initialization
    │       └── clipboard.lua   # Clipboard plugin
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
   # Shell configuration
   ln -sf ~/.dotfiles/.zshrc ~/.zshrc
   ln -sf ~/.dotfiles/.zshenv ~/.zshenv
   
   # Window manager and key daemon
   ln -sf ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
   ln -sf ~/.dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
   chmod +x ~/.config/bspwm/bspwmrc
   
   # Application configurations
   ln -sf ~/.dotfiles/{polybar,kitty,rofi,nvim,fastfetch,dunst,pcmanfm} ~/.config/
   
   # Compositor
   ln -sf ~/.dotfiles/picom/picom.conf ~/.config/picom/picom.conf
   
   # Display manager (requires sudo)
   sudo ln -sf ~/.dotfiles/ly/config.ini /etc/ly/config.ini
   
   # Make scripts executable
   chmod +x ~/.config/polybar/scripts/*.sh ~/.config/polybar/scripts/*/*.sh
   ```

3. **Install Oh My Zsh and plugins**
   ```bash
   # Install Oh My Zsh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   
   # Install additional plugins
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
   
   # Install Powerlevel10k theme
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$ZSH_CUSTOM/themes}/powerlevel10k
   ```

##  Customization

### Colors
The setup uses a consistent Gruvbox color palette:
- Background: `#282828` (polybar), `#32302f` (kitty)
- Foreground: `#ebdbb2`
- Accent colors: `#8ec07c` (green), `#d79921` (yellow), `#458588` (blue)
- Window borders: Focused `#8ec07c`, Normal `#444444`

### Fonts
- Terminal: Configured in `kitty/fonts.conf` and `kitty/kitty.conf`
- Status bar: Configured in `polybar/config.ini`
- Notifications: Configured in `dunst/dunstrc`
- Rofi: Each launcher type has independent font configuration

### Rofi Customization
- **Launchers**: 7 types (type-1 through type-7) with 15 style variations each
- **Power Menus**: 6 types with different button layouts and styles
- **Colors**: 15+ color themes including gruvbox, catppuccin, dracula, onedark, tokyonight, etc.
- Change launcher by editing `sxhkd/sxhkdrc` line 21

### Polybar Modules
Add or remove modules in `polybar/config.ini`:
- Weather: Displays current weather with configurable city
- Bluetooth: Shows status and includes toggle functionality
- System Updates: Monitors available package updates

### Key Bindings
Main keybindings are configured in `sxhkd/sxhkdrc`:
- `super + space`: Application launcher
- `super + t/f/o/c/e`: Launch specific apps (terminal, firefox, obsidian, zed, file manager)
- `super + q`: Close window
- `super + {1-9,0}`: Switch to workspaces
- `super + shift + {1-9,0}`: Move window to workspace
- `super + m`: Minimize window
- `super + u`: Restore minimized window

### Zsh Features
- **Oh My Zsh**: With plugins for git, autosuggestions, syntax highlighting
- **Aliases**: Comprehensive aliases for file operations, git, system management
- **Functions**: Custom functions like `mkcd`, `extract`
- **Integration**: zoxide for smart directory navigation, lsd/exa for enhanced ls

##  Requirements

- **Display Server**: X11 (not Wayland compatible)
- **Shell**: Zsh with Oh My Zsh framework
- **Cursor Theme**: WinSur Dark Cursors (set in bspwmrc)
- **Display Manager**: Ly (alternative to SDDM/GDM with TTY interface)
- **File Manager**: PCManFM for graphical file management
- **Notifications**: Dunst for desktop notifications





##  Features

### Zsh Shell Features
- **Smart Autocompletion**: Context-aware suggestions
- **Syntax Highlighting**: Real-time command validation
- **Git Integration**: Comprehensive git aliases and status
- **Enhanced Navigation**: zoxide for jump-based directory navigation
- **Modern Tools**: lsd/exa for tree views, bat for syntax-highlighted output

### BSPWM Window Management
- **Dynamic Workspaces**: 5 default workspaces with automatic allocation
- **Window Rules**: Specific rules for common applications (Firefox, Gimp, etc.)
- **Visual Feedback**: Colored borders and preselection indicators
- **Minimization**: Full window minimization system with restore functionality

### Rofi Launcher System
- **Multiple Styles**: 7 launcher types with 15+ style variations each
- **Power Management**: 6 different power menu designs
- **Theme Support**: Extensive color theme collection
- **Custom Scripts**: Integration with system functions

### Polybar Status Bar
- **Modular Design**: Configurable modules for different information
- **Weather Display**: Current weather with city configuration
- **Bluetooth Control**: Status monitoring and toggle functionality
- **System Monitoring**: Update checking and system information

### Development Environment
- **Neovim**: NvChad v2.5 with custom plugins and configurations
- **Clipboard Integration**: Enhanced clipboard management
- **LSP Support**: Full Language Server Protocol configuration
- **Modern UI**: Dashboard, file explorer, and fuzzy finding

##  Preview

*(Add screenshots of your setup here)*

##  Contributing

Feel free to fork, modify, and submit pull requests. This is a personal configuration, but suggestions for improvements are welcome!

##  License

This configuration is provided as-is. Feel free to use and modify it for your own setup.

---

**Note**: Backup your existing configurations before installing these dotfiles. Some configurations may require additional setup depending on your system and preferences.

**Tip**: Run `p10k configure` after first shell startup to customize the Powerlevel10k prompt.
# Personal Linux Dotfiles

A curated collection of configuration files for a minimal, productive, and aesthetically pleasing Linux desktop environment built around BSPWM.

## Overview

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

```txt
dotfiles/
├── .zshrc             # Zsh configuration with Oh My Zsh, aliases, and functions
├── .zshenv            # Zsh environment variables
├── bspwm/             # Window manager configuration
│   └── bspwmrc            # BSPWM startup script and rules
├── sxhkd/             # Key bindings for BSPWM
│   └── sxhkdrc            # Comprehensive keybinding configuration
├── polybar/           # Status bar with custom modules
│   ├── config.ini         # Main polybar configuration
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
│   ├── appearance.conf    # Theme settings
│   ├── fonts.conf         # Font configuration
│   └── keybindings.conf   # Terminal shortcuts
├── picom/             # Compositor for effects
│   └── picom.conf         # Animation and transparency settings
├── rofi/              # Application launcher with extensive theming
│   ├── config.rasi         # Global Rofi configuration
│   ├── colors/             # Color themes (gruvbox, catppuccin, dracula, etc.)
│   ├── launchers/          # Launcher types and styles
│   │   └── type-1/         # Multiple style variations
│   ├── powermenu/          # Power menu types
│   │   ├── type-1/         # through type-6
│   │   └── ...
│   ├── applets/            # System applets (volume, brightness, etc.)
│   │   ├── bin/            # Applet scripts
│   │   └── type-1-5/       # Different applet styles
│   └── images/             # Background images for themes
├── dunst/             # Notification daemon
│   ├── dunstrc             # Main notification configuration
│   └── scripts/
│       └── default_script.sh
├── pcmanfm/           # File manager configuration
│   └── default/
│       └── pcmanfm.conf
├── fastfetch/         # System info display
│   └── config.jsonc
├── tint2/             # Panel/taskbar (alternative to polybar)
│   └── tint2rc
├── lidm/              # Lightweight display manager
│   ├── lidm.env
│   └── lidm.ini
├── nvim/              # Neovim configuration (NvChad-based)
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── .stylua.toml
│   ├── lua/
│   │   ├── chadrc.lua
│   │   ├── options.lua
│   │   ├── mappings.lua
│   │   ├── highlights.lua
│   │   └── configs/
│   │       ├── lspconfig.lua
│   │       ├── mason.lua
│   │       ├── conform.lua
│   │       ├── telescope.lua
│   │       ├── snacks.lua
│   │       ├── noice.lua
│   │       └── oil.lua
│   └── lua/plugins/
│       ├── init.lua
│       └── clipboard.lua
└── scripts/           # Custom utility scripts (currently empty)
```

##  Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Install Oh My Zsh and plugins**

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

3. **Install dependencies** (Arch Linux):

   ```bash
   sudo pacman -S bspwm sxhkd polybar rofi dunst kitty picom pcmanfm fastfetch zsh oh-my-zsh powerlevel10k ttf-jetbrains-mono ttf-fira-code nerd-fonts
   ```

   **Optional:**

   ```bash
   sudo pacman -S ly tint2 lidm
   ```

4. **Create symbolic links**

   ```bash
   # Shell configuration
   ln -sf ~/.dotfiles/.zshrc ~/.zshrc
   ln -sf ~/.dotfiles/.zshenv ~/.zshenv
   
   # Window manager and key daemon
   ln -sf ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
   ln -sf ~/.dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
   chmod +x ~/.config/bspwm/bspwmrc
   
   # Application configurations
   ln -sf ~/.dotfiles/{polybar,kitty,rofi,nvim,fastfetch,dunst,pcmanfm,tint2,lidm} ~/.config/
   
   # Compositor
   ln -sf ~/.dotfiles/picom/picom.conf ~/.config/picom/picom.conf
   
   # Display manager (requires sudo)
   sudo ln -sf ~/.dotfiles/ly/config.ini /etc/ly/config.ini
   
   # Make scripts executable
   chmod +x ~/.config/polybar/scripts/*.sh ~/.config/polybar/scripts/*/*.sh
   chmod +x ~/.config/rofi/applets/bin/* ~/.config/rofi/powermenu/*/powermenu.sh
   ```

## Customization

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

## Requirements

### Dependencies

**Core:**

- `bspwm` - Tiling window manager
- `sxhkd` - Simple X hotkey daemon
- `polybar` - Fast and easy-to-use status bar
- `picom` - Compositor for effects and transparency
- `rofi` - Application launcher and window switcher
- `dunst` - Lightweight notification daemon
- `kitty` - Fast terminal emulator
- `zsh` - Z shell
- `oh-my-zsh` - Framework for managing Zsh configuration
- `powerlevel10k` - Zsh theme
- `nvim` (optional) - Neovim text editor with NvChad

**Optional:**

- `ly` - TTY display manager
- `pcmanfm` - Lightweight file manager
- `fastfetch` - System information tool
- `tint2` - Lightweight panel/taskbar (alternative to polybar)
- `lidm` - Lightweight display manager

**Aesthetics:**

- `nerd-fonts` - Fonts with icons (JetBrains Mono, FiraCode, etc.)
- `lxappearance` - GTK theme configuration
- `picom` - Compositor with blur/animations

**Display Server**: X11 (not Wayland compatible)

## Features

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

## Preview

*(Add screenshots of your setup here)*

## Contributing

Feel free to fork, modify, and submit pull requests. This is a personal configuration, but suggestions for improvements are welcome!

## License

This configuration is provided as-is. Feel free to use and modify it for your own setup.

---

**Note**: Backup your existing configurations before installing these dotfiles. Some configurations may require additional setup depending on your system and preferences.

**Tip**: Run `p10k configure` after first shell startup to customize the Powerlevel10k prompt.

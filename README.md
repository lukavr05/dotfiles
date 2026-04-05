# Dotfiles

Configuration files for a minimal, productive Linux desktop environment built around BSPWM.

## Overview

A curated collection of config files for a tiling window manager setup. Includes configurations for the shell (Zsh), window manager (BSPWM), status bar (Polybar), terminal (Kitty), and other desktop components. Designed for Arch Linux but adaptable to other distributions.

## Prerequisites

- **OS**: Arch Linux (or similar Arch-based distribution)
- **Display Server**: X11
- **Package Manager**: pacman
- **Shell**: Zsh

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install core dependencies:

   ```bash
   sudo pacman -S bspwm sxhkd polybar rofi dunst kitty picom pcmanfm fastfetch zsh
   ```

3. Install optional dependencies:

   ```bash
   sudo pacman -S ly tint2 lidm
   ```

4. Install Oh My Zsh:

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

5. Install Zsh plugins:

   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
   ```

6. Install Powerlevel10k theme:

   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```

7. Create symbolic links:

   ```bash
   ln -sf ~/.dotfiles/.zshrc ~/.zshrc
   ln -sf ~/.dotfiles/.zshenv ~/.zshenv
   ln -sf ~/.dotfiles/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
   ln -sf ~/.dotfiles/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
   chmod +x ~/.config/bspwm/bspwmrc
   ln -sf ~/.dotfiles/polybar ~/.config/
   ln -sf ~/.dotfiles/kitty ~/.config/
   ln -sf ~/.dotfiles/rofi ~/.config/
   ln -sf ~/.dotfiles/nvim ~/.config/
   ln -sf ~/.dotfiles/fastfetch ~/.config/
   ln -sf ~/.dotfiles/dunst ~/.config/
   ln -sf ~/.dotfiles/picom ~/.config/
   ```

8. Make scripts executable:

   ```bash
   chmod +x ~/.config/polybar/launch.sh
   chmod +x ~/.config/polybar/scripts/*.sh
   chmod +x ~/.config/polybar/scripts/*/*.sh
   ```

## Usage

Start X11 with BSPWM. The window manager will load automatically with the configured settings.

### Key Bindings

| Shortcut | Action |
|----------|--------|
| `super + space` | Application launcher |
| `super + t` | Terminal (Kitty) |
| `super + f` | File manager |
| `super + q` | Close window |
| `super + {1-9,0}` | Switch workspace |
| `super + shift + {1-9,0}` | Move window to workspace |
| `super + m` | Minimize window |
| `super + u` | Restore minimized window |

## Project Structure

```
dotfiles/
├── .zshrc              # Zsh configuration with Oh My Zsh
├── .zshenv            # Environment variables
├── bspwm/             # Window manager config
│   └── bspwmrc
├── sxhkd/             # Hotkey daemon
│   └── sxhkdrc
├── polybar/           # Status bar
│   ├── config.ini
│   ├── launch.sh
│   └── scripts/       # Weather, bluetooth, updates
├── kitty/             # Terminal config
├── rofi/              # Application launcher
├── nvim/              # Neovim (NvChad-based)
├── dunst/             # Notifications
├── picom/             # Compositor
├── fastfetch/         # System info
├── tint2/             # Panel (optional)
├── lidm/              # Display manager (optional)
└── pcmanfm/           # File manager
```

## Development

This is a configuration repository - no tests or builds required. To make changes:

1. Edit the relevant config file
2. Reload the component (e.g., restart BSPWM, source .zshrc)

## License

MIT License - feel free to use and modify for your own setup.

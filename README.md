# Dotfiles

A comprehensive dotfiles management system with automated installation, device-specific configurations, and symbolic link management.

## 🚀 Quick Start

### Installation
```bash
git clone <repository-url> dotfiles
cd dotfiles
bash install.sh
```

## 📁 Project Structure

```
.
├── install.sh          # Main installation script
├── init.sh            # Shell initialization (sourced by .zshrc)
├── up.sh              # System update script
├── symlinks.sh        # Symbolic links creation script
├── aliases/           # Shell aliases
│   ├── init.sh        # Loads all alias files
│   ├── dfox.sh        # Dfox-specific aliases
│   ├── git.sh         # Git aliases
│   └── shell.sh       # General shell aliases
├── apps/              # Application configurations
│   ├── macos/         # macOS-specific apps
│   │   ├── install_or_update_all.py  # Homebrew package manager
│   │   └── [device]/  # Device-specific configurations
│   └── linux/         # Linux-specific apps
│       └── [device]/  # Device-specific configurations
├── dots/              # Dotfiles to be symlinked
│   └── zsh/           # Zsh configurations
└── symlinks/          # Symlink configuration
    ├── create_symlinks.py  # Python script for creating symlinks
    ├── general.json       # General symlink configurations
    └── [device].json      # Device-specific symlink configurations
```

## 🛠 Scripts

### `install.sh`
Main installation script that:
- Sets up the DFOX_PATH environment variable
- Checks for Python 3 installation
- Syncs dotfiles to `~/.dotfiles`
- Installs Zimfw (Zsh framework)
- Configures `.zshrc` with dotfiles initialization
- Creates symbolic links

### `up.sh`
System update script that:
- **macOS**: Updates Homebrew packages via `install_or_update_all.py`
- **Linux**: Runs the installation script
- Automatically detects the operating system

### `symlinks.sh`
Creates symbolic links by:
- Validating the environment (DFOX_PATH, Python 3)
- Executing the Python symlink creation script
- Providing error handling and validation

### `apps/macos/install_or_update_all.py`
Python script for managing macOS applications:
- **Arguments**:
  - `-m, --mode`: `install` or `update`
  - `-d, --device`: Device name (defaults to hostname)
- Manages Homebrew packages, casks, and Mac App Store applications
- Loads device-specific configuration files

## 🔗 Aliases

### General Shell Aliases (`aliases/shell.sh`)
- `la` - List all files (`ll -a`)
- `..` - Go up one directory (`cd ..`)
- `...` - Go up two directories (`cd ../..`)
- `....` - Go up three directories (`cd ../../..`)
- `up` - Run system update script (`bash $DFOX_PATH/up.sh`)

### Git Aliases (`aliases/git.sh`)
- `gs` - Git status (`git status`)
- `gc` - Git commit (`git commit`)
- `gd` - Git diff (`git diff`)
- `gps` - Git push (`git push`)
- `gpl` - Git pull (`git pull`)
- `gaa` - Git add all (`git add --all`)

### Dfox Aliases (`aliases/dfox.sh`)
- `dfox_test_alias` - Test alias functionality (`echo working!`)
- `dfox_reload` - Reload dotfiles configuration (`source $DFOX_PATH/init.sh`)
- `dfox_symlinks` - Create symbolic links (`bash $DFOX_PATH/symlinks.sh`)

## 🔧 Configuration

### Environment Variables
- `DFOX_PATH` - Path to dotfiles directory (default: `$HOME/.dotfiles`)

### Device-Specific Configurations
The system supports device-specific configurations by organizing files under device names:
- `apps/macos/[device]/homebrew/` - Device-specific Homebrew packages
- `apps/linux/[device]/dnf/` - Device-specific Linux packages
- `symlinks/[device].json` - Device-specific symbolic links

### Symbolic Links Configuration
Symbolic links are configured via JSON files in the `symlinks/` directory:

```json
[
  {
    "file": "dots/zsh/.zshrc",
    "link": "~",
    "force": true
  },
  {
    "file": "dots/git/.gitconfig",
    "link": "~"
  }
]
```

**Fields**:
- `file` - Relative path to source file within dotfiles
- `link` - Destination directory (supports `~` expansion)
- `force` - Optional. If `true`, overwrites existing files/links

## 🎨 Shell Prompt

The system includes a custom Zsh prompt featuring:
- 🦊 Fox emoji
- ✓ Green checkmark for successful commands
- ✗ Red X for failed commands
- Current directory display

Example: `🦊 ✓ ~/.dotfiles `

## 🔄 Usage Examples

### Update system packages
```bash
up
# or
dfox_reload && up
```

### Recreate symbolic links
```bash
dfox_symlinks
```

### Install/update with specific device
```bash
# For macOS
python3 apps/macos/install_or_update_all.py --mode update --device ahsoka
```

### Reload dotfiles configuration
```bash
dfox_reload
```

## 🎯 Features

- ✅ Cross-platform support (macOS/Linux)
- ✅ Device-specific configurations
- ✅ Automatic symbolic link management
- ✅ Homebrew package management
- ✅ Git workflow aliases
- ✅ Custom shell prompt with status indicators
- ✅ Modular alias system
- ✅ Force overwrite capability for symlinks
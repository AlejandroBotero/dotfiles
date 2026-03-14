# Workspace Context: dotfiles

This repository contains personal configuration files (dotfiles) for a Linux environment, primarily targeting i3wm, Polybar, Picom, and Neovim (LazyVim).

## Core Architecture

- **Management Strategy**: Manual symlinking via scripts.
- **Entry Points**:
  - `setconf.sh`: Orchestrates the full setup (dependencies + linking).
  - `commands/link_conf.sh`: Handles symlinking files from the repo to target locations in `~` and `/etc`.
  - `commands/install_dependencies.sh`: Installs required system packages.

## Key Technologies & Configurations

- **Window Manager**: i3wm (`i3.config`).
- **Terminal**: Kitty (`kitty.conf`).
- **Shell**: Zsh (`.zshrc`, `.bashrc` as fallback).
- **Editor**: Neovim with LazyVim (`nvim/`).
- **System Utilities**:
  - `dunst`: Notification daemon (`dunstrc`).
  - `keyd`: Keyboard remapping (`keyd.conf`, `keyd5layer.conf`).
  - `picom`: Compositor for transparency/blur (`picom.conf`).
  - `polybar`: Status bar (`polybar.conf`).
  - `tmux`: Terminal multiplexer (`.tmux.conf`).
- **Keyboard Layouts**: Custom XKB symbols (`custom`, `custom_ru`).

## Conventions for Agents

1. **Surgical Updates**: When modifying config files, preserve existing comments and structure.
2. **Symlink Awareness**: Always check `commands/link_conf.sh` to confirm where a file is mapped before suggesting changes that might affect system-wide paths (e.g., `/etc/keyd/`).
3. **LazyVim Standards**: Neovim changes should follow LazyVim's plugin and config structure in `nvim/lua/plugins/` and `nvim/lua/config/`.
4. **Testing**: Validate syntax for specific tools after changes (e.g., `i3 -C`, `kitty --check-config`).
5. **Permissions**: Note that some scripts and symlinks require `sudo`.

## Workspace Structure

- `commands/`: Setup scripts.
- `nvim/`: Complete Neovim configuration.
- `scripts/`: Utility scripts (e.g., `gpu_usage.sh`).
- Root files: Various `.conf` and dotfiles.

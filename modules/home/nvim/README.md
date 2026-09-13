# AstroNvim

**NOTE:** Personalized config for AstroNvim

This repository is a personalized AstroNvim setup.

## Main features

Besides the defaults that come from AstroNvim:

- cord.nvim (discord rich presence)
- showkeys.nvim (show off your keystrokes)
- blink.cmp (completion plugin)
- copilot completion integrated into blink.cmp
- hella lot of colorschemes
- flash.nvim (faster navigation)

## Requirements

### Neovim requirements

This configuration expects:

- Neovim installed and working from the terminal
- Git, because `lazy.nvim` is cloned on first launch
- A Nerd Font for icons and UI symbols
- Network access for plugin downloads and Mason package installation

Recommended, but not strictly required:

- `ripgrep` for faster searching
- `fd` for file pickers and search tools
- `tree-sitter-cli` if you want parser tooling outside Mason

### Plugin requirements

The plugins used by this config have the following external requirements:

- AstroNvim, AstroCommunity, `lazy.nvim`, `blink.cmp`, `flash.nvim`, `cinnamon.nvim`, `noice.nvim`, `showkeys.nvim`, and the colorscheme plugins do not require extra system packages beyond Neovim and Git
- Copilot-related plugins need a GitHub Copilot account and authentication inside Neovim
- `cord.nvim` needs Discord running if you want rich presence updates
- The clipboard setup in `lua/polish.lua` is Linux-specific and requires `wl-copy` and `wl-paste` from `wl-clipboard`
- Mason-managed tools install on demand, so the machine needs outbound network access for first-time setup

The bundled Mason list currently installs:

- `lua-language-server`
- `stylua`
- `debugpy`
- `tree-sitter-cli`

## Installation

### Common first step

Before installing this config, back up any existing Neovim data:

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Then clone this repository into `~/.config/nvim`:

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

### Windows

Install the prerequisites with Winget or your preferred package manager:

```powershell
winget install Git.Git
winget install Neovim.Neovim
```

Install a Nerd Font such as JetBrainsMono Nerd Font, then restart your terminal so the font is available.

If you use Discord Rich Presence, install and sign in to Discord before launching Neovim.

Clone the config into your Neovim config directory:

```powershell
git clone https://github.com/<your_user>/<your_repository> $env:LOCALAPPDATA\nvim
```

Start Neovim:

```powershell
nvim
```

### Linux

Install the core tools first. Use the package manager for your distro.

Debian or Ubuntu:

```shell
sudo apt update
sudo apt install git neovim ripgrep fd-find wl-clipboard
```

Fedora:

```shell
sudo dnf install git neovim ripgrep fd-find wl-clipboard
```

Arch:

```shell
sudo pacman -S git neovim ripgrep fd wl-clipboard
```

Make sure a Nerd Font is installed in your terminal, then clone the repository:

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

If you want clipboard support, keep `wl-clipboard` installed so `lua/polish.lua` can use `wl-copy` and `wl-paste`.

### macOS

Install the core tools with Homebrew:

```shell
brew install git neovim ripgrep fd
```

Install a Nerd Font through Homebrew Cask or your preferred font manager:

```shell
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

Then clone the repository:

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

### First launch

```shell
nvim
```

On the first launch, `lazy.nvim` will install itself and then fetch the configured plugins.

### Install plugins and language tools

Inside Neovim:

```
:Lazy
```

Install the language tools you need with Mason:

```
:Mason install <package>
```

If you prefer the UI:

```
:Mason
```

Then select the packages you want to install.

### You're done!

> Pressing space in normal mode will show the keymap helpers.

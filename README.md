This repository contains my Neovim setup, including plugins, LSP configuration, and custom settings. Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim), which will be auto-installed.

## Prerequisites

- Neovim (v0.9 or newer)
- Git
- Node
- Pip3
- Python3

## Installation

1. **Clone this repository into your Neovim config directory:**
   ```sh
   git clone https://github.com/tejasmk-tkp/nvim_config.git ~/.config/nvim
   ```

2. **Launch Neovim:**
   ```sh
   nvim
   ```
   - On first launch, `lazy.nvim` and all plugins will be automatically installed.

3. **Install LSP servers:**
   - Open Neovim and run:
     ```
     :Mason
     ```
   - Use the Mason UI to install desired language servers.

## Updating

To update your configuration and plugins:
```sh
cd ~/.config/nvim
git pull
nvim
:Lazy sync
```

## Troubleshooting

- Run `:checkhealth` in Neovim to diagnose issues with plugins, LSP, or your environment.

> **Note:** This setup may not be fully replicable on every system. If you encounter any issues, please open an issue so I can address it and help future users.

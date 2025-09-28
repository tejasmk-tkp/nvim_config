This repository contains my Neovim setup, including plugins, LSP configuration, and custom settings. Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim), which will be auto-installed.

## Features

- **Catppuccin theme** for a beautiful, modern look.  
- **Telescope** for fuzzy finding files, live grep, buffers, commands.  
- **Neo-tree** for file explorer with floating and sidebar modes.  
- **LSP integration** (via `nvim-lspconfig` + Mason) for multiple languages.  
- **Treesitter** for better syntax highlighting and indentation.  
- **Auto-completion** with `nvim-cmp` + snippets (`LuaSnip` + `friendly-snippets`).  
- **Auto pairs & tags** (`nvim-autopairs`, `nvim-ts-autotag`) for closing brackets, quotes, and tags.  
- **Git integration** with `gitsigns.nvim` + `vim-fugitive`.  
- **Code formatting & linting** via `null-ls` (formatters + diagnostics).  
- **GitHub Copilot** + Copilot Chat for AI pair programming.  
- **Window & buffer management** with leader-key mappings.  
- **Debugging** with `nvim-dap` + UI.  
- **Which-key** for discoverable keymaps. 

## Prerequisites

- neovim
- git
- ripgrep
- lynx
- gh
- nodejs
- npm
- python3-pip
- xclip
- xsel
- python3-pynvim
- clang
- cmake
- clang-format
- ninja-build
- codespell

**Note:** Please install the latest versions of the deps, most often the one's found in apt are outdated and can cause a lot of issues.

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

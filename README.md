# Dotfiles

Configuration to setup my dev env

Mostly Neovim and bash

This setup is specifically tailored for **Asahi Fedora Remix** on Apple Silicon hardware and Ubuntu, but can be adapted for other Linux distributions.

## Features

*   **Modern Neovim:** Configuration is fully written in Lua.
*   **Fast Plugin Management:** Uses `lazy.nvim` for asynchronous plugin loading.
*   **Enhanced UI:** Comes with `tokyonight` colorscheme, `lualine.nvim` for the statusbar, and `neo-tree.nvim` as a file explorer.
*   **Powerful Python Development:**
    *   **LSP:** Full-featured language server support via `pyright` for diagnostics, code completion, and navigation.
    *   **Formatting:** Automatic formatting on save using `ruff_format`.
    *   **Linting:** High-performance linting with `ruff`.
*   **Excellent Markdown Support:**
    *   **Live Preview:** In-browser preview using `markdown-preview.nvim`.
    *   **Syntax Highlighting:** Accurate highlighting with `nvim-treesitter`.
*   **Productivity Boosters:**
    *   **Fuzzy Finding:** `telescope.nvim` for finding files, text, and more.
    *   **Git Integration:** Seamless git workflows with `vim-fugitive`.
    *   **Distraction-Free Writing:** `goyo.vim` for a clean writing interface.

## Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/shon/dotfiles.git
    cd dotfiles
    ```

2.  **Run the setup script:**
    This script will install all necessary packages (Neovim, git, etc.) and create the required symlinks.
    ```bash
    sh ./init.sh
    ```
    The script will pause and ask you to manually install a [Nerd Font](https://www.nerdfonts.com/font-downloads), which is required for UI icons to render correctly. Follow the instructions in the terminal.

3.  **Launch Neovim:**
    The first time you start Neovim, `lazy.nvim` will automatically install all the plugins.
    ```bash
    nvim
    ```

That's it! Your modern development environment is ready.

## Further Improvements

This codebase has been significantly modernized, but here are a few more suggestions for improvement:

*   **Shell and Terminal:**
    *   Consider switching from `bash` to a more modern shell like `zsh` with a framework like [Oh My Zsh](https://ohmyz.sh/) or a faster alternative like [Fish](https://fishshell.com/).
    *   Explore modern terminal emulators like [Kitty](https://sw.kovidgoyal.net/kitty/) or [Alacritty](https://alacritty.org/), which offer better performance and features like GPU rendering.
*   **Dotfiles Management:**
    *   For managing a larger set of dotfiles, consider using a dedicated tool like [chezmoi](https://www.chezmoi.io/) or [stow](https://www.gnu.org/software/stow/). These tools can make it easier to manage configurations across multiple machines.
*   **Neovim Customization:**
    *   The current Neovim setup is powerful, but you can customize it further. Explore adding plugins for things like:
        *   Database integration (`vim-database`).
        *   REST client (`rest.nvim`).
        *   More advanced debugging with `nvim-dap`.

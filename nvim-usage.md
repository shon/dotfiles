# Neovim Usage Guide

This guide provides an overview of the customized Neovim setup in this repository, focusing on its key features and how to use them effectively.

## Core Philosophy

This Neovim configuration is built to be a fast, modern, and powerful development environment, primarily customized for Python and Markdown development. It uses `lazy.nvim` for plugin management, ensuring that plugins are loaded efficiently.

## Key Bindings

The `<leader>` key is mapped to `/` (default).

### File and Code Navigation

*   **File Explorer (`neo-tree.nvim`)**
    *   Toggle the file explorer sidebar: `<F2>`

*   **Symbol Outline (`outline.nvim`)**
    *   Toggle the code symbol outline: `<leader>o`
    *   This sidebar lists all the symbols (functions, classes, variables, etc.) in the current file, allowing for quick navigation.

*   **Fuzzy Finding (`telescope.nvim`)**
    *   Find files: `<leader>ff`
    *   Search for text in the project (live grep): `<leader>fg`
    *   List open buffers: `<leader>fb`
    *   Search help tags: `<leader>fh`

### Python Development

This setup is optimized for Python development with a full-featured LSP, formatting, and linting.

*   **Language Server (LSP)**
    *   The `pyright` language server provides diagnostics, code completion, and navigation.
    *   Go to definition: `gd`
    *   Find references: `gr`
    *   Show documentation/hover: `K`
    *   Rename symbol: `<space>rn`
    *   Show code actions (e.g., for imports): `<space>ca`

*   **Formatting**
    *   Python files are automatically formatted on save using `ruff_format`.

*   **Linting**
    *   High-performance linting is provided by `ruff`. Errors and warnings will be highlighted in the editor.

### Markdown Support

*   **Live Preview**
    *   Toggle an in-browser live preview for your Markdown files with the command `:MarkdownPreviewToggle`.

### Git Integration

*   **Fugitive**
    *   This setup includes `vim-fugitive`, a powerful Git wrapper. You can run any Git command directly from Neovim using `:Git <command>` (e.g., `:Git status`, `:Git blame`).

### Other Productivity Tools

*   **Distraction-Free Mode (`goyo.vim`)**
    *   Toggle a centered, distraction-free writing mode with `:Goyo`.

*   **Paste Mode**
    *   Toggle paste mode with `<F3>`. This is useful when pasting code to prevent auto-indentation issues.

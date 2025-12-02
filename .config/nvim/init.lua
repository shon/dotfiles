-- Neovim configuration in Lua

-- [[ ---------------- `lazy.nvim` setup ---------------- ]]
-- The following code bootstraps lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ ---------------- Plugin Configuration ---------------- ]]
-- Configure plugins using lazy.nvim
require("lazy").setup({
  -- LSP and tooling
  'neovim/nvim-lspconfig', -- Core LSP configuration
  'williamboman/mason.nvim', -- Manages LSP servers, DAP servers, linters, and formatters
  'williamboman/mason-lspconfig.nvim', -- Bridge between Mason and nvim-lspconfig

  -- Autocompletion (a basic setup)
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',

  -- UI and Aesthetics
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "hedyhli/outline.nvim",
    event = "VimEnter",
    keys = { { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" } },
    config = function()
        require("outline").setup({
            outline_window = {
                split_command = 'topleft',
            },
        })
        vim.cmd("Outline")
    end
  },

  -- Syntax and Highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "markdown" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- Productivity
  'tpope/vim-fugitive', -- Git integration
  'junegunn/goyo.vim', -- Distraction-free writing
  {
    'iamcco/markdown-preview.nvim',
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Formatting and Linting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
        require('lint').linters_by_ft = {
            python = {'ruff'}
        }
    end
  }
})

-- [[ ---------------- Neovim Settings ---------------- ]]
-- Set editor options
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
vim.opt.laststatus = 2

-- Set colorscheme
vim.cmd.colorscheme "lunaperche"

-- Configure lualine
require('lualine').setup {
  options = {
    colorscheme = 'lunaperche',
    section_separators = { left = '|', right = '|' },
    component_separators = { left = ':', right = ':' }
  }
}

-- [[ ---------------- Key Mappings ---------------- ]]
-- Set leader key
-- vim.g.mapleader = ','

-- General keymaps
vim.keymap.set('n', '<F2>', ':Neotree toggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})


-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

-- LSP keymaps
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
end

-- [[ ---------------- LSP Configuration ---------------- ]]
-- Configure Mason
require('mason').setup()

-- Configure nvim-cmp
local cmp = require'cmp'
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
})

-- Configure LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason-lspconfig').setup({
  ensure_installed = { "pyright" },
  handlers = {
    function (server_name)
      require('lspconfig')[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities
      }
    end,
  }
})

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})

-- [[ ---------------- Additional Customizations ---------------- ]]
-- Add keymap for toggling paste mode
vim.keymap.set('n', '<F3>', function()
  vim.opt.paste = not vim.opt.paste:get()
  if vim.opt.paste:get() then
    print("Paste mode is ON")
  else
    print("Paste mode is OFF")
  end
end, { silent = true, desc = "Toggle paste mode" })

-- Filetype-specific indentation
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'jade', 'vue' }, -- Settings from original .vimrc
  callback = function(args)
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Open outline on startup
-- Open outline on startup (handled by plugin config)


print("Neovim config loaded!")

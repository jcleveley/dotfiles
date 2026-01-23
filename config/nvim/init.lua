-- ============================================================================
-- Neovim Configuration - Lean & Simple with Catppuccin Mocha
-- ============================================================================

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ============================================================================
-- Plugin Management (lazy.nvim)
-- ============================================================================

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  -- Catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        transparent_background = false,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
          cmp = true,
          gitsigns = true,
          telescope = true,
        },
      })
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },

  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
      if not status_ok then
        return
      end
      treesitter.setup({
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'bash', 'python', 'javascript', 'typescript' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      local status_ok, nvimtree = pcall(require, 'nvim-tree')
      if not status_ok then
        return
      end
      nvimtree.setup({
        view = { width = 30 },
        renderer = {
          group_empty = true,
          icons = {
            glyphs = {
              default = '',
              symlink = '',
              folder = {
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
              },
            },
          },
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    config = function()
      local status_ok, telescope = pcall(require, 'telescope')
      if not status_ok then
        return
      end
      telescope.setup({
        defaults = {
          layout_strategy = 'horizontal',
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = { prompt_position = 'top' },
          },
          file_ignore_patterns = { 'node_modules', '.git/', 'dist/', 'build/' },
          -- Fix treesitter preview error
          buffer_previewer_maker = function(filepath, bufnr, opts)
            opts = opts or {}
            filepath = vim.fn.expand(filepath)
            require('plenary.job'):new({
              command = 'cat',
              args = { filepath },
              on_exit = function(j)
                vim.schedule(function()
                  if vim.api.nvim_buf_is_valid(bufnr) then
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, j:result())
                  end
                end)
              end
            }):start()
          end,
        },
      })
    end,
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local status_ok, gitsigns = pcall(require, 'gitsigns')
      if not status_ok then
        return
      end
      gitsigns.setup()
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function()
      local status_ok, lualine = pcall(require, 'lualine')
      if not status_ok then
        return
      end
      lualine.setup({
        options = {
          theme = 'catppuccin',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
      })
    end,
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local status_ok, autopairs = pcall(require, 'nvim-autopairs')
      if not status_ok then
        return
      end
      autopairs.setup()
    end,
  },

  -- Comment
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' } },
      { 'gb', mode = { 'n', 'v' } },
    },
    config = function()
      local status_ok, comment = pcall(require, 'Comment')
      if not status_ok then
        return
      end
      comment.setup()
    end,
  },
})

-- ============================================================================
-- Key Mappings
-- ============================================================================

-- File explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Fuzzy find files' })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Find buffers' })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Clear search highlight
vim.keymap.set('n', '<Esc>', ':noh<CR>', { silent = true })

-- Save and quit
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

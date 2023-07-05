local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup({ function(use)
  -- Packer can manage it self
  use 'wbthomason/packer.nvim'                                                                           -- A plugin manager for Neovim
  use 'lewis6991/impatient.nvim'                                                                         -- Speeds up Neovim's startup time
  use "nathom/filetype.nvim"                                                                             -- Faster filetype detection
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = "require('plugins.treesitter')" } -- Tree-sitter integration for Neovim, providing better syntax highlighting and code navigation
  use 'neovim/nvim-lspconfig'                                                                            -- A collection of common configurations for Neovim's built-in Language Server Protocol (LSP) support
  use { 'goolord/alpha-nvim', config = "require('plugins.alpha')" }                                      -- A start screen plugin for Neovim
  use { 'williamboman/mason.nvim' }                                                                      -- Plugin for managing Neovim configurations in a modular way
  use { 'williamboman/mason-lspconfig.nvim' }                                                            -- Plugin for managing Neovim configurations in a modular way
  use { 'romgrk/barbar.nvim', config = "require('plugins.barbar')" }                                     -- A plugin for managing and navigating between multiple buffers
  use "nvim-lua/popup.nvim"                                                                              -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"                                                                            -- Useful lua functions used by lots of plugins
  use { "numToStr/Comment.nvim", config = "require('plugins.comment')" }                                 -- Easily comment stuff
  use { 'akinsho/nvim-toggleterm.lua', config = "require('plugins.toggleterm')" }                        -- A plugin for managing and toggling terminal windows in Neovim
  use "kyazdani42/nvim-web-devicons"                                                                     -- Adds file type icons to various Neovim plugins
  use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }                       -- Sets the commentstring for treesitter based on the
  use { 'folke/which-key.nvim', config = "require('plugins.which-key')", event = "BufWinEnter" }         -- Displays available key mappings when a key sequence is partially entered
  use { 'folke/trouble.nvim', config = "require('plugins.trouble')" }                                    -- A diagnostics plugin for LSP
  use { 'sindrets/diffview.nvim' }                                                                       -- A side-by-side diff viewer for Neovim
  use { 'github/copilot.vim' }                                                                           -- GitHub Copilot integration for Neovim
  use 'wakatime/vim-wakatime'                                                                            -- Integrates WakaTime for tracking coding metrics in Neovim
  use({
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    requires = { "nvim-lua/plenary.nvim" },
  })                                           -- Utility functions and TypeScript support for Neovim's LSP
  use { 'jose-elias-alvarez/typescript.nvim' } -- Utility functions and TypeScript support for Neovim's LSP

  -- Context treesitter
  use 'nvim-treesitter/nvim-treesitter-context' -- Displays the current code context based on tree-sitter

  -- Rust
  use { 'simrat39/rust-tools.nvim', config = "require('plugins.rust')" } -- Rust tooling for Neovim, including inlay hints, code actions, and more

  use { 'j-hui/fidget.nvim', config = "require('plugins.fidget')", tag = 'legacy'}      -- Displays LSP loading status

  -- Themes
  -- use {'bluz71/vim-nightfly-guicolors'}
  -- use {'folke/tokyonight.nvim'}
  -- use { 'EdenEast/nightfox.nvim' }
  -- use { 'gruvbox-community/gruvbox' }
  -- use { "ellisonleao/gruvbox.nvim", config = "require('plugins.gruvbox')" }
  -- use 'shaunsingh/nord.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- A plugin for annotating and browsing TODO comments in your code
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", config = "require('plugins.todo-comments')" }

  -- A plugin for highlighting CSS color codes in Neovim
  use { 'norcalli/nvim-colorizer.lua', config = "require('plugins.colorizer')" }

  -- A plugin for previewing markdown files using the glow CLI
  use { "ellisonleao/glow.nvim" }

  -- Projects
  use { 'ahmedkhalf/project.nvim', config = "require('plugins.project')" }

  -- Harpoon
  -- use {'ThePrimeagen/harpoon'}

  -- A lightweight status line for Neovim
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = "require('plugins.lualine')"
  }

  -- indent line
  use { 'lukas-reineke/indent-blankline.nvim', config = "require('plugins.indent')" }

  -- autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  --LSP
  use { "jose-elias-alvarez/null-ls.nvim", config = "require('lsp.null-ls')" } -- for formatters and linters

  -- autocomplete
  use { 'hrsh7th/nvim-cmp', config = "require('plugins.nvim-cmp')" }
  use { 'onsails/lspkind-nvim' }
  use { 'L3MON4D3/LuaSnip', dependencies = "rafamadriz/friendly-snippets" }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

  --Nvim Tree
  use { 'kyazdani42/nvim-tree.lua', branch = "master", config = "require('plugins.tree')" }
  use { 'airblade/vim-rooter',
    config = function()
      vim.g.rooter_patterns = M42.plugins.rooter.patterns
    end
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    config = "require('plugins.telescope/init')",
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' }
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'cljoly/telescope-repo.nvim' }


  -- Git
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('plugins.gitsigns')",
    event = "BufRead"
  }
end,
})

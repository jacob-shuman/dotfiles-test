-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- font
vim.cmd('set guifont=Monocraft')

-- line numbers
vim.wo.relativenumber = true

-- bootstrap lazy nvim
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

local plugins = {
	"nvim-treesitter/nvim-treesitter",
	"ayu-theme/ayu-vim",
	{
        	"folke/tokyonight.nvim",
  		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	"nvim-tree/nvim-web-devicons",
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		'nvim-lualine/lualine.nvim',
  		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
	},
}


require("lazy").setup(plugins, {})

-- theme
vim.cmd.colorscheme "ayu"

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)

require'nvim-web-devicons'.setup()

-- lualine
require('lualine').setup {
  options = {
    theme = 'tokyonight',
  }
}

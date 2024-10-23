-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- line numbers
vim.wo.relativenumber = true
vim.wo.number = true

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
	{
		'goolord/alpha-nvim',
		dependencies = { 'echasnovski/mini.icons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		'stevearc/conform.nvim',
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "javascript", "html", "css", "typescript", "svelte", "markdown" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
			})
		end
	},
	{
		'Shatur/neovim-ayu',
		lazy = false,
		priority = 1000,
		config = function()
			require('ayu').setup({
				mirage = false,
				terminal = true,
				overrides = {},
			})
		end
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

-- tab width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- telescope
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,  -- Go to the next item
				["<C-k>"] = actions.move_selection_previous, -- Go to the previous item
			},
		},
	},
}

-- require("telescope").load_extension "file_browser"

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
		theme = 'ayu',
	}
}

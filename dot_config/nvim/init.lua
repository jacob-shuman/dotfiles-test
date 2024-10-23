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
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
	-- autocompletion
	{ "hrsh7th/cmp-cmdline" },
	{
		'stevearc/conform.nvim',
		opts = {},
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run the first available formatter
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
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

-- noice
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

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

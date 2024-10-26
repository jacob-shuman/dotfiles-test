-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
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
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile	" },
		config = function()
			local conform = require("conform")
			conform.setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
					stop_after_first = true,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettierd", "prettier" },
					typescript = { "prettierd", "prettier" },
					svelte = { "prettierd", "prettier" },
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "javascript", "html", "css", "typescript", "svelte", "markdown" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"Shatur/neovim-ayu",
		lazy = false,
		priority = 1000,
		config = function()
			require("ayu").setup({
				mirage = false,
				terminal = true,
				overrides = {},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"nvim-tree/nvim-web-devicons",
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	},
}

require("lazy").setup(plugins, {})

-- sync nvim and system clipboard
vim.opt.clipboard = "unnamedplus"

-- indent on line wrap
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case insensitive search (unless \C or one or more capital letters are in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time (displays which-key popup sooner)
vim.opt.timeoutlen = 300

-- TODO: CONTINUE FROM HERE

-- theme
vim.cmd.colorscheme("ayu")
vim.g.have_nerd_font = true
vim.opt.showmode = false

-- custom line number colors
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3D4149" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F09552" })

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
		-- command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	command_palette = {
		popupmenu = {
			relative = "editor",
			position = {
				row = 23,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
				max_height = 15,
			},
			border = {
				style = "rounded",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
			},
		},
	},
})

-- telescope
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next, -- Go to the next item
				["<C-k>"] = actions.move_selection_previous, -- Go to the previous item
			},
		},
	},
})

-- require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
	"n",
	"<space>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true }
)

require("nvim-web-devicons").setup()

-- lualine
require("lualine").setup({
	options = {
		theme = "ayu",
	},
})

-- files without extensions use bash
vim.cmd([[
  augroup set_bash_for_no_extension
    autocmd!
    autocmd BufNewFile,BufRead * if expand("%:e") == "" | setlocal filetype=bash | endif
  augroup END
]])

-- TODO: add indent rainbow plugin
-- TODO: add linting plugin(s)
-- TODO: add autocompletion plugin(s)
-- TODO: add filetree plugin
-- TODO: figure out git usage
-- TODO: figure out spotify usage
-- TODO: add tmux and/or window/panel remaps
-- TODO: add sessions
-- TODO: figure out integrated terminal possibly

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
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
			-- log_level = 'debug',
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

	-- NOTE: comments

	-- uses correct comment syntax in embedded languages (svelte, vue, etc)
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- https://github.com/numToStr/Comment.nvim
	-- comment easily using common mappings in
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- styles TODO, NOTE, FIX, etc messages
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- NOTE: indent rainbow

	-- {
	-- 	"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
	-- 	config = function()
	-- 		local rainbow_delimiters = require("rainbow-delimiters")
	--
	-- 		vim.g.rainbow_delimiters = {
	-- 			strategy = {
	-- 				[""] = rainbow_delimiters.strategy["global"],
	-- 				vim = rainbow_delimiters.strategy["local"],
	-- 			},
	-- 			query = {
	-- 				[""] = "rainbow-delimiters",
	-- 				lua = "rainbow-blocks",
	-- 			},
	-- 			highlight = {
	-- 				"RainbowDelimiterOrange",
	-- 				"RainbowDelimiterBlue",
	-- 				"RainbowDelimiterRed",
	-- 				"RainbowDelimiterYellow",
	-- 				"RainbowDelimiterGreen",
	-- 				"RainbowDelimiterViolet",
	-- 				"RainbowDelimiterCyan",
	-- 			},
	-- 		}
	-- 	end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
}

require("lazy").setup(plugins, {})

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
local actions = require("telescope.actions")

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

-- require("telescope").load_extension("persisted")

require("nvim-web-devicons").setup()

-- lualine
require("lualine").setup({})

-- Comment.nvim
require("Comment").setup()

-- indent-blankline.nvim
local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({ indent = { highlight = highlight } })
--[[ local highlight = {
	"RainbowOrange",
	"RainbowBlue",
	"RainbowRed",
	"RainbowYellow",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup({ scope = { highlight = highlight } })

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)]]

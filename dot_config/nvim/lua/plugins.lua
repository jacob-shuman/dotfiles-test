-- TODO: add linting plugin(s)
-- TODO: add autocompletion plugin(s)
-- TODO: add filetree plugin
-- TODO: figure out git usage
-- TODO: figure out spotify usage
-- TODO: add tmux and/or window/panel remaps
-- TODO: add sessions
-- TODO: figure out integrated terminal possibly
-- TODO: add smart opener (https://github.com/danielfalk/smart-open.nvim)
-- TODO: add ollama plugin

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

	-- NOTE: sessions
	--
	-- {
	-- 	"rmagatti/auto-session",
	-- 	lazy = false,
	--
	-- 	---enables autocomplete for opts
	-- 	---@module "auto-session"
	-- 	---@type AutoSession.Config
	-- 	opts = {
	-- 		suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
	-- 		-- log_level = 'debug',
	-- 	},
	-- },

	-- NOTE: git
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- NOTE: formatting
	--
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

	-- NOTE: theme
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

	-- NOTE: icons
	"nvim-tree/nvim-web-devicons",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	},

	-- NOTE: telescope (fuzzy finder)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	-- NOTE: smart file search
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
	},
	-- NOTE: file tree

	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	-- 	},
	-- },
	{
		"lambdalisue/fern.vim",
		config = function()
			-- Open in a split window (e.g., vertical split by default)
			vim.g["fern#default_hidden"] = 1 -- Show hidden files
			vim.g["fern#renderer"] = "default" -- Use the default renderer
		end,
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

	-- NOTE: vertical indentation lines

	-- https://github.com/lukas-reineke/indent-blankline.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	-- NOTE: color highlighting (hex, rgba, hsl, etc)
	-- TODO: add nvim-cmp integration if i add it later

	-- https://github.com/brenoprata10/nvim-highlight-colors
	"brenoprata10/nvim-highlight-colors",
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
require("ibl").setup()

-- nvim-highlight-colors
require("nvim-highlight-colors").setup({})

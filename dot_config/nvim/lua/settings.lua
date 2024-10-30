-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- line numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- tab width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 30

-- disable listing ignored files/directories in fern
vim.g.fern_git_status_disable_ignored = 1

-- files without extensions use bash
vim.cmd([[
  augroup set_bash_for_no_extension
    autocmd!
    autocmd BufNewFile,BufRead * if expand("%:e") == "" | setlocal filetype=bash | endif
  augroup END
]])

-- correctly set .gitconfig file type
vim.cmd([[
  autocmd BufRead,BufNewFile \.gitconfig,git/config set filetype=gitconfig
]])

-- correctly set .gitignore file type
vim.cmd([[
  autocmd BufRead,BufNewFile .gitignore set filetype=gitignore
]])

-- set highlight on search but clear it on <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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

-- TODO: pick better characters
-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "▸ ", -- Display tabs with an arrow
	trail = "·", -- Display trailing spaces as a dot
	space = "·", -- Display regular spaces as a dot
	nbsp = "␣", -- Display non-breaking spaces as a special character
}

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

-- files without extensions use bash
vim.cmd([[
  augroup set_bash_for_no_extension
    autocmd!
    autocmd BufNewFile,BufRead * if expand("%:e") == "" | setlocal filetype=bash | endif
  augroup END
]])

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

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }
vim.api.nvim_set_hl(0, "Whitespace", { ctermfg = "gray", guifg = "#5c6370" })
vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = "darkgray", guifg = "#5c6370" })

require("settings")
require("plugins")
require("remap")
require("theme")

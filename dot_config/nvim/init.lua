-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }

require("settings")
require("plugins")
require("remap")
require("theme")

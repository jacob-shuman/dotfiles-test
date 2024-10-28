vim.cmd.colorscheme("ayu")
vim.g.have_nerd_font = true
vim.opt.showmode = false

-- custom line number colors
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3D4149" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F09552" })
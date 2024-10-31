vim.cmd.colorscheme("ayu")
-- vim.cmd.colorscheme("rose-pine")
vim.g.have_nerd_font = true
vim.opt.showmode = false
vim.opt.termguicolors = true

-- custom line number colors
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3D4149" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F09552" })

-- whitespace color
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3D4149" })

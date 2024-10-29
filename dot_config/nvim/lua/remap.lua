-- NOTE: git
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })

-- NOTE: telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader><leader>", function()
	require("telescope").extensions.smart_open.smart_open()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.api.nvim_set_keymap(
	"n",
	"<space>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true }
)

-- NOTE: ferm.vim
-- Open fern in a vertical split with Ctrl-n
vim.api.nvim_set_keymap(
	"n",
	"<C-n>",
	":Fern . -reveal=% -drawer -toggle -right -width=30<CR>",
	{ noremap = true, silent = true }
)

-- NOTE: todo comments
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

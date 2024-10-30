-- NOTE: git

vim.keymap.set("n", "<leader>g", ":LazyGit<CR>", { noremap = true, silent = true })

-- NOTE: telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fa", function()
	require("telescope").extensions.smart_open.smart_open()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = true }
)

-- NOTE: ferm.vim
-- Open fern in a vertical split with Ctrl-n
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<C-n>",
-- 	":Fern . -reveal=% -toggle -drawer -right -width=30<CR>",
-- 	-- ":Fern . -reveal=% -drawer -toggle -right -width=30<CR>",
-- 	{ noremap = true, silent = true }
-- )
vim.api.nvim_set_keymap("n", "<C-n>", ":vsplit | :Fern . -reveal=% -toggle<CR>", { noremap = true, silent = true })

-- NOTE: todo comments
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- NOTE: auto command to yank the current line, comment it, and paste it underneath
-- NOTE: this doesn't override the default register

local function yank_comment_paste()
	local comment = require("Comment.api")
	-- if vim.fn.mode() == "v" then
	-- 	vim.cmd([[normal! "ay]])
	-- 	vim.cmd([[normal! gv]])
	-- 	vim.cmd([[normal! I# ]])
	-- 	vim.cmd([[normal! gv]])
	-- 	vim.cmd([[normal! "ap]])
	-- 	vim.fn.setreg("a", "")
	-- else
	vim.cmd([[normal! "ayy]])
	comment.toggle.linewise.current()
	vim.cmd([[normal! "ap]])
	vim.fn.setreg("a", "")
	-- end
end

-- vim.api.nvim_set_keymap("n", "<leader>yc", ":lua yank_comment_paste()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gcp", yank_comment_paste, { noremap = true, silent = true, desc = "yank comment paste" })
vim.api.nvim_set_keymap("v", "<leader>yc", ":<C-u>lua yank_comment_paste()<CR>", { noremap = true, silent = true })

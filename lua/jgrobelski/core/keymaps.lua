local keymap = vim.keymap

--[[ 
Prefix - Keys
Meta-Prefixes:
- s: window management
- g: go to X
- r: refractor/fix
- a: action
- l: linting

Plugin-Prefixes:
- c: diff
- Q: Quickfix
- f: telescope 
- d: Debug 
- G: git

--]]

-- basic
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>qq", "<cmd> bd <CR><cmd> q! <CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>") -- save
keymap.set("n", "<leader>n", ":Neotree toggle<CR>") -- save
keymap.set("n", "m", ":")
keymap.set("c", "jj", "<ESC>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- window navigation
vim.api.nvim_set_keymap("n", "<BS>", ":e#<CR>", { noremap = true, silent = true }) -- Map Ctrl + Tab to switch back to the previous file
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- Down
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- Up
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- Left
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- Right

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
keymap.set("n", "<leader>sm", "<C-w><5") -- make split windows width smaller

-- tab management
keymap.set("n", "<leader>o", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>x", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- next diff hunk
keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "Qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "Qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "Qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "Qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "Ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "Qc", ":cclose<CR>") -- close quickfix list

-- Telescope key mappings with descriptions
local telescope_builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
keymap.set(
	"n",
	"<leader>fg",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Live Grep WITH ARGS" }
)
keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "List buffers" })
keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Help tags" })
keymap.set("n", "<leader>fs", telescope_builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fo", telescope_builtin.lsp_document_symbols, { desc = "LSP document symbols" })
keymap.set("n", "<leader>fi", telescope_builtin.lsp_incoming_calls, { desc = "LSP incoming calls" })
keymap.set("n", "<leader>fm", function()
	telescope_builtin.treesitter({ default_text = ":method:" })
end, { desc = "Treesitter symbols" })

keymap.set("n", "<leader>so", ":SymbolsOutline<CR>", { desc = "Toggle Symbols Outline" }) -- Keybinding to toggle SymbolsOutline

-- spectre
vim.api.nvim_set_keymap("n", "<leader>Sr", "<cmd>lua require('spectre').open()<CR>", { noremap = true, silent = true })

-- Set LSP keybindings
keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" })
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Show LSP definitions" })
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Show LSP implementations" })
keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Show LSP type definitions" })
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Smart rename" })
keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show line diagnostics" })
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic" })
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show documentation for what is under cursor" })
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Show signature help" })
keymap.set("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { desc = "Show document symbols" })
keymap.set("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", { desc = "Show workspace symbols" })
keymap.set("n", "<leader>af", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Show code actions" })
keymap.set("n", "<leader>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>", { desc = "Show line diagnostics" })
keymap.set("n", "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Smart rename" })
keymap.set("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", { desc = "Format buffer" })
keymap.set("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", { desc = "Show incoming calls" })
keymap.set("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", { desc = "Show outgoing calls" })
keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Jump to next diagnostic" })
keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Jump to previous diagnostic" })

--Trouble
keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
keymap.set(
	"n",
	"<leader>xd",
	"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Open trouble document diagnostics" }
)
keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })

-- Refractor
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

--linting
vim.keymap.set("n", "<leader>l", function()
	require("lint").try_lint()
end, { desc = "Trigger linting for current file" })

-- Debugging
keymap.set("n", "<leader>dbb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "DAP: Toggle breakpoint" })
keymap.set(
	"n",
	"<leader>dbc",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	{ desc = "DAP: Set conditional breakpoint" }
)
keymap.set(
	"n",
	"<leader>dbl",
	"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	{ desc = "DAP: Set log point" }
)
keymap.set("n", "<leader>dbr", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "DAP: Clear all breakpoints" })
keymap.set("n", "<leader>dba", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "DAP: List breakpoints" })
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "DAP: Continue execution" })
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = "DAP: Step over" })
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", { desc = "DAP: Step into" })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = "DAP: Step out" })
keymap.set("n", "<leader>dd", function()
	require("dap").disconnect()
	require("dapui").close()
end, { desc = "DAP: Disconnect and close UI" })
keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end, { desc = "DAP: Terminate and close UI" })
keymap.set("n", "<leader>dui", function()
	require("dap").disconnect()
	require("dapui").close()
end, { desc = "DAP: Toggle DAP UI" })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "DAP: Toggle REPL" })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "DAP: Run last debug session" })
keymap.set("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP: Hover over variable" })
keymap.set("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "DAP: Show scopes in floating window" })
keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>", { desc = "DAP: Show frames" })
keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", { desc = "DAP: Show commands" })
keymap.set("n", "<leader>de", function()
	require("telescope.builtin").diagnostics({ default_text = ":E:" })
end, { desc = "DAP: Show diagnostics with :E: filter" })

-- code runner
vim.keymap.set("n", "<leader>R", ":RunCode<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>Rf", ":RunFile<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>Rft", ":RunFile tab<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>Rp", ":RunProject<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>Rc", ":RunClose<CR>", { noremap = true, silent = false })

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
keymap.set("n", "<leader>h1", function()
	require("harpoon.ui").nav_file(1)
end)
keymap.set("n", "<leader>h2", function()
	require("harpoon.ui").nav_file(2)
end)
keymap.set("n", "<leader>h3", function()
	require("harpoon.ui").nav_file(3)
end)
keymap.set("n", "<leader>h4", function()
	require("harpoon.ui").nav_file(4)
end)
keymap.set("n", "<leader>h5", function()
	require("harpoon.ui").nav_file(5)
end)
keymap.set("n", "<leader>h6", function()
	require("harpoon.ui").nav_file(6)
end)
keymap.set("n", "<leader>h7", function()
	require("harpoon.ui").nav_file(7)
end)
keymap.set("n", "<leader>h8", function()
	require("harpoon.ui").nav_file(8)
end)
keymap.set("n", "<leader>h9", function()
	require("harpoon.ui").nav_file(9)
end)

-- Tutorials / Help
-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>H", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [N]eovim files" })
-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Git
keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
-- keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>") -- toggle git blame

--[[
--buffer
keymap.set('n','<CTRL>o','<cmd>bd!')


-- Training Plugins
keymap.set("n", '<leader><leader>x', "<cmd>lua require'precognition'.toggle()<cr>")

]]
--

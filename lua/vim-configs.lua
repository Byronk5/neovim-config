vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set number")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "number"
vim.o.clipboard = "unnamedplus"

-- Screen splits
vim.api.nvim_set_keymap("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<leader>s", ":split<CR>", { noremap = true, silent = true })

--Buffer Navigation
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprevious <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", ":bd <CR>", { noremap = true, silent = true })

--Automatically close brackets, parethesis, and quotes
vim.api.nvim_set_keymap("i", "'", "''<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "\"", "\"\"<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "(", "()<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "[", "[]<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "{", "{}<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "{;", "{};<left><left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "/*", "/**/<left><left>", { noremap = true, silent = true })
--vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

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
vim.api.nvim_set_keymap("i", '"', '""<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "(", "()<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "[", "[]<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "{", "{}<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "{;", "{};<left><left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "/*", "/**/<left><left>", { noremap = true, silent = true })
--vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

--Comment lines in react

-- Toggle JSX comments in normal mode
vim.api.nvim_set_keymap("n", "<leader>/", ":lua ToggleJSXComment()<CR>", { noremap = true, silent = true })

-- Toggle JSX comments in visual mode
vim.api.nvim_set_keymap("v", "<leader>/", ":lua ToggleJSXCommentVisual()<CR>", { noremap = true, silent = true })

-- Function to toggle JSX comment on a single line
function ToggleJSXComment()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*{%/%*") then
    -- Remove JSX comment
    line = line:gsub("{/%*%s?", "", 1):gsub("%s?%*/}", "", 1)
  else
    -- Add JSX comment
    line = line:gsub("^%s*", "%0{/* ") .. " */}"
  end
  vim.api.nvim_set_current_line(line)
end

-- Function to toggle JSX comments in visual mode
function ToggleJSXCommentVisual()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  for i = start_line, end_line do
    local line = vim.fn.getline(i)
    if line:match("^%s*{%/%*") then
      -- Remove JSX comment
      line = line:gsub("{/%*%s?", "", 1):gsub("%s?%*/}", "", 1)
    else
      -- Add JSX comment
      line = line:gsub("^%s*", "%0{/* ") .. " */}"
    end
    vim.fn.setline(i, line)
  end
end

--return {
--  "neovim-neo-tree/neo-tree.nvim",
--  branch = "v2.x",
--  dependencies = {
--    "nvim-lua/plenary.nvim",
--    "nvim-tree/nvim-web-devicons",
--    "MunifTanjim/nui.nvim",
--  },
--  config = function()
--    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right <CR>", {})
--  end,
--}
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right <CR>", {})
  end,
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
  },
}

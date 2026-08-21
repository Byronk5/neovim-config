return {
  "neovim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        width = 30,
      },
    })

    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right <CR>", {})

    -- `:bd` closes every window showing the buffer, and Vim then re-equalizes the
    -- layout, letting the neo-tree split swallow the freed width. Swap the window
    -- onto another buffer first so no window is ever closed.
    local function delete_current_buffer()
      local cur = vim.api.nvim_get_current_buf()

      local function usable(buf)
        return buf ~= cur and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
      end

      local replacement = nil
      local alt = vim.fn.bufnr("#")
      if usable(alt) then
        replacement = alt
      else
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if usable(buf) then
            replacement = buf
            break
          end
        end
      end
      replacement = replacement or vim.api.nvim_create_buf(true, false)

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == cur then
          vim.api.nvim_win_set_buf(win, replacement)
        end
      end

      pcall(vim.api.nvim_buf_delete, cur, {})
    end

    vim.keymap.set("n", "<leader>d", delete_current_buffer, { noremap = true, silent = true })
  end,
}

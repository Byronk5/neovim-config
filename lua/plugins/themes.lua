local use_tokyonight = true

if use_tokyonight then
  return {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_colors = function(colors)
          --colors.bg = "#1a1b26" -- Set your custom background color
          colors.bg = "none" -- Set your custom background color
          -- Customize other colors here if needed
          -- colors.bg_sidebar = "#1c1d2f" -- Example for sidebar background
        end,
      })
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  }
else
  return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 999,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  }
end

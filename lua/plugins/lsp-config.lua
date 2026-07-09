return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- nvim-lspconfig v2 dropped the require("lspconfig").<server>.setup()
      -- framework. It now only ships lsp/<server>.lua definitions that Neovim's
      -- own vim.lsp.config()/vim.lsp.enable() read, and mason-lspconfig calls
      -- vim.lsp.enable() for every installed server. So there is nothing to
      -- start here -- only settings to layer on top.

      -- Merged into every server, underneath that server's own lsp/<name>.lua.
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Prettier owns formatting. eslint-config-prettier strips ESLint's
      -- stylistic rules, so formatting through eslint would only fight Prettier.
      vim.lsp.config("eslint", {
        settings = {
          format = { enable = false },
        },
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      vim.diagnostic.config({
        virtual_text = true, -- Disables virtual text
        signs = true,     -- Show signs in gutter
        float = {
          border = "rounded", -- Use rounded borders for diagnostics
          source = "always", -- Show the source of the diagnostics
        },
      })

      -- Keymap to manually show diagnostics in a floating window
      vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { border = "rounded" })
      end, { noremap = true, silent = true })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- Order matters: mason must be set up so the registry exists, and
    -- nvim-lspconfig must have run so vim.lsp.config("*") is registered before
    -- automatic_enable starts clients against the buffer nvim was opened with.
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        -- Server names, not mason package names. Everything already installed
        -- under mason is enabled automatically (automatic_enable defaults true).
        ensure_installed = { "lua_ls", "cssls", "html", "ts_ls", "pyright" },
      })
    end,
  },
}

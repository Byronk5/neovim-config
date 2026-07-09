--return {
--  {
--    "williamboman/mason.nvim",
--    config = function()
--      require("mason").setup()
--    end,
--  },
--  {
--    "williamboman/mason-lspconfig.nvim",
--    config = function()
--      require("mason-lspconfig").setup({
--        ensure_installed = { "lua_ls", "cssls", "html", "ts_ls", "pyright" },
--      })
--    end,
--  },
--  {
--    "neovim/nvim-lspconfig",
--    config = function()
--      local capabilities = require("cmp_nvim_lsp").default_capabilities()
--      local lspconfig = require("lspconfig")
--      lspconfig.lua_ls.setup({
--        capabilities = capabilities,
--      })
--      lspconfig.ts_ls.setup({
--        capabilities = capabilities,
--      })
--      lspconfig.cssls.setup({
--        capabilities = capabilities,
--      })
--      lspconfig.html.setup({
--        capabilities = capabilities,
--      })
--      lspconfig.pyright.setup({
--        capabilities = capabilities,
--      })
--      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
--      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
--      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
--
--      vim.diagnostic.config({
--        virtual_text = true, -- Disables virtual text
--        signs = true,     -- Show signs in gutter
--        float = {
--          border = "rounded", -- Use rounded borders for diagnostics
--          source = "always", -- Show the source of the diagnostics
--        },
--      })
--
--      -- Keymap to manually show diagnostics in a floating window
--      vim.keymap.set("n", "<leader>e", function()
--        vim.diagnostic.open_float(nil, { border = "rounded" })
--      end, { noremap = true, silent = true })
--    end,
--  },
--}
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"cssls",
					"html",
					"ts_ls",
					"pyright",
					"eslint",
					"ruby_lsp",
				},
				automatic_enable = {
					exclude = { "rubocop" },
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			--local lspconfig = require("lspconfig")
			--local util = require("lspconfig.util")

			--lspconfig.lua_ls.setup({ capabilities = capabilities })
			--lspconfig.ts_ls.setup({ capabilities = capabilities }) -- corrected to tsserver
			--lspconfig.cssls.setup({ capabilities = capabilities })
			--lspconfig.html.setup({ capabilities = capabilities })
			--lspconfig.pyright.setup({ capabilities = capabilities })

			---- ✅ ESLint LSP setup
			--lspconfig.eslint.setup({
			--	capabilities = capabilities,
			--	root_dir = util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json"),
			--	settings = {
			--		format = { enable = true },
			--	},
			--})

			-- Apply capabilities to all servers
			vim.lsp.config("*", { capabilities = capabilities })

			-- ESLint-specific overrides.
			--
			-- No root_markers here on purpose: nvim-lspconfig's lsp/eslint.lua defines
			-- root_dir as a function, and :h lsp-root_markers says root_markers is
			-- "Unused if root_dir is defined". It already probes every flat-config and
			-- legacy filename, so the server starts only in repos that really use
			-- ESLint, and stays silent everywhere else.
			vim.lsp.config("eslint", {
				settings = {
					-- Prettier owns formatting. eslint-config-prettier strips ESLint's
					-- stylistic rules, so formatting here would only fight Prettier.
					format = { enable = false },
				},
			})

			vim.lsp.enable({ "lua_ls", "ts_ls", "cssls", "html", "pyright", "eslint", "ruby_lsp" })

			-- LSP Keymaps
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float(nil, { border = "rounded" })
			end, { noremap = true, silent = true })
		end,
	},
}

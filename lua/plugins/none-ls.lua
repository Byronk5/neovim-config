--return {
--	"nvimtools/none-ls.nvim",
--  dependencies = { "nvim-lua/plenary.nvim" },
--	config = function()
--		local null_ls = require("null-ls")
--		null_ls.setup({
--			sources = {
--				null_ls.builtins.formatting.stylua,
--				null_ls.builtins.formatting.prettier.with({
--					--extra_args = { "--config", ".prettierrc" },
--					condition = function(utils)
--						return utils.root_has_file({ ".prettierrc", ".prettierrc.js", ".prettierrc.json" })
--					end,
--				}),
--				null_ls.builtins.formatting.black,
--				--null_ls.builtins.formatting.pyright,
--				--null_ls.builtins.formatting.isort,
--				null_ls.builtins.diagnostics.eslint_d.with({
--					condition = function(utils)
--						return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
--					end,
--				}),
--			},
--		})
--		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
--	end,
--}


return {
	"nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")

		-- Prettier reads a dozen config filenames (.prettierrc, .prettierrc.yaml,
		-- prettier.config.mjs, ...) and also a top-level "prettier" key in
		-- package.json. Matching only three of them made Prettier silently skip
		-- repos that do use it, falling through to tsserver's formatter instead.
		local function has_prettier_config(utils)
			if utils.root_has_file_matches("^%.prettierrc") then
				return true
			end
			if utils.root_has_file_matches("^prettier%.config%.") then
				return true
			end
			local root = vim.fs.root(0, { "package.json" })
			if not root then
				return false
			end
			local fd = io.open(root .. "/package.json", "r")
			if not fd then
				return false
			end
			local raw = fd:read("*a")
			fd:close()
			local ok, pkg = pcall(vim.json.decode, raw)
			-- A "prettier" devDependency is not a config; only a top-level key is.
			return ok and type(pkg) == "table" and pkg.prettier ~= nil
		end

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.htmlbeautifier,
				null_ls.builtins.formatting.prettier.with({
					condition = has_prettier_config,
				}),
				null_ls.builtins.formatting.black,
				--null_ls.builtins.formatting.pyright,
				--null_ls.builtins.formatting.isort,
			--	null_ls.builtins.diagnostics["eslint-lsp"].with({
			--		condition = function(utils)
			--			return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
			--		end,
			--	}),
			},
		})
		-- vim.lsp.buf.format() runs EVERY attached client that supports formatting
		-- (ts_ls, eslint, null-ls), applying each one's edits in attach order, so
		-- whichever attaches last silently wins. Pick one deliberately instead:
		--
		--   * Repo has a Prettier config -> null-ls only, so the result is
		--     byte-identical to what a prettier pre-commit hook would produce.
		--   * No Prettier config -> fall back to the language server (tsserver,
		--     lua_ls, ...) rather than doing nothing.
		--
		-- eslint is always excluded: it formats via `eslint --fix`, which either
		-- fights Prettier or, with eslint-config-prettier, has no style rules left.
		vim.keymap.set("n", "<leader>gf", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local prettier = vim.lsp.get_clients({
				bufnr = bufnr,
				name = "null-ls",
				method = "textDocument/formatting",
			})
			vim.lsp.buf.format({
				bufnr = bufnr,
				filter = function(client)
					if #prettier > 0 then
						return client.name == "null-ls"
					end
					return client.name ~= "eslint"
				end,
			})
		end, {})
	end,
}

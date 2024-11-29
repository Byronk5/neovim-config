return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					--extra_args = { "--config", ".prettierrc" },
					condition = function(utils)
						return utils.root_has_file({ ".prettierrc", ".prettierrc.js", ".prettierrc.json" })
					end,
				}),
				null_ls.builtins.formatting.black,
				--null_ls.builtins.formatting.pyright,
				--null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
					end,
				}),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}

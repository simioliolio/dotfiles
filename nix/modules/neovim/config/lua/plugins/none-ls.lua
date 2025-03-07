return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
        null_ls.builtins.diagnostics.statix,
				null_ls.builtins.formatting.stylua,
			},
		})
		vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, {})
	end,
}

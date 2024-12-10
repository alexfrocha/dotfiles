return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Dependência comum para plugins como o null-ls
	},
	config = function()
		local null_ls = require("null-ls")

		-- Configuração do null-ls com vários formatadores
		null_ls.setup({
			sources = {
				-- Formatter para Python (black)
				null_ls.builtins.formatting.black.with({
					extra_args = { "--fast" },
				}),

				-- Formatter para JavaScript/TypeScript (prettier)
				null_ls.builtins.formatting.prettier,

				-- Formatter para Go (gofmt)
				null_ls.builtins.formatting.gofmt,

				-- Formatter para C/C++ (clang-format)
				null_ls.builtins.formatting.clang_format,

				-- Formatter para Lua (stylua)
				null_ls.builtins.formatting.stylua,
			},

			-- Habilitar a formatação automática ao salvar
			on_attach = function(client, bufnr)
				-- Verificar se o cliente tem a capacidade de formatação
				if client.server_capabilities.documentFormattingProvider then
					-- Configurar o autocmd para formatar o código ao salvar
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							-- Executa a formatação antes de salvar
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}

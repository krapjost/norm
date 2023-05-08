return function()
	local null_ls = require("null-ls")
	local h = require("null-ls.helpers")
	local methods = require("null-ls.methods")

	local gleam_formatter = h.make_builtin({
		name = "gleam",
		meta = {
			url = "https://github.com/gleam-lang/gleam",
			description = "Gleam's official formatter",
		},
		method = methods.internal.FORMATTING,
		filetypes = { "gleam" },
		generator_opts = {
			command = "gleam",
			args = { "format", "$FILENAME" },
			to_stdin = false,
		},
		factory = h.formatter_factory,
	})

	null_ls.setup({
		sources = {
			gleam_formatter.with({
				filetypes = { "gleam" },
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.rustfmt,
			null_ls.builtins.formatting.dprint.with({
				filetypes = {
					"toml",
					"markdown",
					"json",
					"dockerfile",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"html",
					"css",
					"scss",
				},
			}),
			null_ls.builtins.formatting.prettierd.with({
				filetypes = { "yaml" },
			}),
		},
		on_attach = function(client, bufnr)
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(server)
								return server.name == "null-ls"
							end,
						})
						vim.api.nvim_exec("edit!", false)
					end,
				})
			end
		end,
	})
end

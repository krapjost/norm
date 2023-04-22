return function()
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
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
        },
      }),
      null_ls.builtins.formatting.prettierd.with({
        filetypes = { "html", "yaml", "css", "scss", "less" },
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
                return server.name ~= "null-ls"
              end,
            })
          end,
        })
      end
    end,
  })
end

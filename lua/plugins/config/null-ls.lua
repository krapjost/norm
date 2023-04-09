return function()
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.dprint,
    },
    on_attach = function(client, bufnr)
      if client.name ~= "null-ls" then
        return
      end
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end,
  })
end

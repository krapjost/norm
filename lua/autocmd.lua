local au = vim.api.nvim_create_autocmd

local function au_when_lsp(capa, bufnr)
  au('BufWritePost', {
    pattern = { '*.js', '*.ts', '*.jsx', '*.tsx' },
    desc = 'fix-linting-problems',
    command = 'EslintFixAll',
  })
  if capa.documentFormattingProvider then
    return au('BufWritePre', {
      buffer = bufnr,
      desc = 'format-on-save',
      command = 'lua vim.lsp.buf.format()',
    })
  else
    return nil
  end
end

return { ['au-when-lsp'] = au_when_lsp }

Heirline = require('heirline')
-- local utils = heirline.utils
-- local conditions = heirline.conditions
-- local FileNameBlock = {
--   -- let's first set up some attributes needed by this component and it's children
--   init = function(self)
--     self.filename = vim.api.nvim_buf_get_name(0)
--   end,
-- }
-- local FileType = {
--   provider = function()
--     return string.upper(vim.bo.filetype)
--   end,
--   Heirline = { fg = utils.get_highlight('Type').fg, bold = true },
-- }
--
-- local Space = { provider = ' ' }
--
-- local TerminalName = {
--   -- we could add a condition to check that buftype == 'terminal'
--   -- or we could do that later (see #conditional-statuslines below)
--   provider = function()
--     local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
--     return ' ' .. tname
--   end,
--   Heirline = { fg = 'blue', bold = true },
-- }
--
-- local WinBars = {
--   fallthrough = false,
--   { -- A special winbar for terminals
--     condition = function()
--       return conditions.buffer_matches({ buftype = { 'terminal' } })
--     end,
--     utils.surround({ '', '' }, 'dark_red', {
--       FileType,
--       Space,
--       TerminalName,
--     }),
--   },
--   { -- An inactive winbar for regular files
--     condition = function()
--       return not conditions.is_active()
--     end,
--     utils.surround(
--       { '', '' },
--       'bright_bg',
--       { Heirline = { fg = 'gray', force = true }, FileNameBlock }
--     ),
--   },
--   -- A winbar for regular files
--   utils.surround({ '', '' }, 'bright_bg', FileNameBlock),
-- }

return function()
  Heirline.setup({
    -- winbar = WinBars,
  })
end

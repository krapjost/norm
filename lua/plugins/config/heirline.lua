return function()
  local heir = require('heirline')
  local utils = require('heirline.utils')
  local conditions = require('heirline.conditions')

  local colors = {
    bright_bg = utils.get_highlight('Folded').bg,
    bright_fg = utils.get_highlight('Folded').fg,
    red = utils.get_highlight('DiagnosticError').fg,
    dark_red = utils.get_highlight('DiffDelete').bg,
    green = utils.get_highlight('String').fg,
    blue = utils.get_highlight('Function').fg,
    gray = utils.get_highlight('NonText').fg,
    orange = utils.get_highlight('Constant').fg,
    purple = utils.get_highlight('Statement').fg,
    cyan = utils.get_highlight('Special').fg,
    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
    diag_error = utils.get_highlight('DiagnosticError').fg,
    diag_hint = utils.get_highlight('DiagnosticHint').fg,
    diag_info = utils.get_highlight('DiagnosticInfo').fg,
    git_del = utils.get_highlight('DiffDelete').fg,
    git_add = utils.get_highlight('DiffAdd').fg,
    git_change = utils.get_highlight('DiffChange').fg,
  }

  heir.load_colors(colors)

  local Space = { provider = ' ' }
  local FileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }
  local FileType = {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight('Type').fg, bold = true },
  }

  local TerminalName = {
    -- we could add a condition to check that buftype == 'terminal'
    -- or we could do that later (see #conditional-statuslines below)
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
      return ' ' .. tname
    end,
    hl = { fg = 'blue', bold = true },
  }

  local WinBars = {
    fallthrough = false,
    {
      condition = function()
        return conditions.buffer_matches({ buftype = { 'terminal' } })
      end,
      utils.surround({ '', '' }, 'dark_red', {
        FileType,
        Space,
        TerminalName,
      }),
    },
    { -- An inactive winbar for regular files
      condition = function()
        return not conditions.is_active()
      end,
      utils.surround(
        { '', '' },
        'bright_bg',
        { hl = { fg = 'gray', force = true }, FileNameBlock }
      ),
    },
    -- A winbar for regular files
    utils.surround({ '', '' }, 'bright_bg', FileNameBlock),
  }

  heir.setup({
    winbar = WinBars,
    opts = {
      -- if the callback returns true, the winbar will be disabled for that window
      -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
      disable_winbar_cb = function(args)
        local buf = args.buf
        local buftype = vim.tbl_contains(
          { 'prompt', 'nofile', 'help', 'quickfix' },
          vim.bo[buf].buftype
        )
        local filetype = vim.tbl_contains(
          { 'gitcommit', 'fugitive', 'Trouble', 'packer' },
          vim.bo[buf].filetype
        )
        return buftype or filetype
      end,
    },
  })
end

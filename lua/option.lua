local opt = vim.opt
local o = vim.o
local g = vim.g

vim.go.fillchars = 'eob: '

o.statusline = '%{%v:lua.require\'nvim-navic\'.get_location()%}'
opt.cmdheight = 0
opt.laststatus = 3
opt.pumheight = 8
opt.autoread = true
-- opt.autochdir = true
opt.termguicolors = true
opt.background = 'dark'
opt.ignorecase = true
opt.cursorline = true
opt.smartcase = true
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.timeoutlen = 100
opt.smartindent = true
opt.expandtab = true
opt.wrap = false
opt.sidescroll = 10
opt.clipboard = 'unnamedplus'
opt.list = true
opt.mouse = 'a'
opt.updatetime = 50
g.neoterm_default_mod = 'botright'
g.neoterm_autoscroll = 1
g.neoterm_size = 13

if g.neovide then
  opt.guifont = { 'FiraCode Nerd Font Mono', ':h9' }
  g.neovide_hide_mouse_when_typing = true
  g.neovide_scroll_animation_length = 0.1
  g.neovide_cursor_animation_length = 0.1
  g.neovide_cursor_trail_size = 0.5
  g.neovide_cursor_antialiasing = true
  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_animate_command_line = false
  g.neovide_cursor_vfx_particle_density = 100
  g.neovide_cursor_vfx_particle_speed = 50
  g.neovide_cursor_vfx_particle_lifetime = 0.5
  g.neovide_cursor_vfx_mode = 'pixiedust'
end

local colors = require('poimandres.palette')

local TelescopeColor = {
  TelescopeMatching = { fg = colors.teal1 },
  TelescopeSelection = {
    fg = colors.text,
    bg = colors.background1,
    bold = true,
  },
  TelescopePromptBorder = { fg = colors.blueGray1 },
  TelescopeResultsBorder = { fg = colors.blueGray1 },
  TelescopePreviewBorder = { fg = colors.blueGray1 },
  TelescopeResultsNormal = { fg = colors.blueGray1 },
  TelescopePromptNormal = { fg = colors.teal1 },
  TelescopePromptTitle = { fg = colors.blueGray1 },
  TelescopeResultsTitle = { fg = colors.blueGray1 },
  TelescopePreviewTitle = { fg = colors.blueGray1 },
}

for hl, col in pairs(TelescopeColor) do
  vim.api.nvim_set_hl(0, hl, col)
end

local NavicColors = {
  NavicIconsModule = { default = true, fg = colors.blue1 },
  NavicIconsNamespace = { default = true, fg = colors.blue1 },
  NavicIconsPackage = { default = true, fg = colors.blue1 },
  NavicIconsClass = { default = true, fg = colors.blue1 },
  NavicIconsMethod = { default = true, fg = colors.blue1 },
  NavicIconsProperty = { default = true, fg = colors.blue1 },
  NavicIconsField = { default = true, fg = colors.blue1 },
  NavicIconsConstructor = { default = true, fg = colors.blue1 },
  NavicIconsEnum = { default = true, fg = colors.blue1 },
  NavicIconsInterface = { default = true, fg = colors.blue1 },
  NavicIconsFunction = { default = true, fg = colors.blue1 },
  NavicIconsVariable = { default = true, fg = colors.blue1 },
  NavicIconsConstant = { default = true, fg = colors.blue1 },
  NavicIconsString = { default = true, fg = colors.blue1 },
  NavicIconsNumber = { default = true, fg = colors.blue1 },
  NavicIconsBoolean = { default = true, fg = colors.blue1 },
  NavicIconsArray = { default = true, fg = colors.blue1 },
  NavicIconsObject = { default = true, fg = colors.blue1 },
  NavicIconsKey = { default = true, fg = colors.blue1 },
  NavicIconsNull = { default = true, fg = colors.blue1 },
  NavicIconsEnumMember = { default = true, fg = colors.blue1 },
  NavicIconsStruct = { default = true, fg = colors.blue1 },
  NavicIconsEvent = { default = true, fg = colors.blue1 },
  NavicIconsOperator = { default = true, fg = colors.blue1 },
  NavicIconsTypeParameter = { default = true, fg = colors.blue1 },
  NavicIconsFile = { default = true, fg = colors.blue1 },
  NavicText = { default = true, fg = colors.text },
}

for hl, col in pairs(NavicColors) do
  vim.api.nvim_set_hl(0, hl, col)
end

function CopyMatches(line1, line2, reg)
  local hits = {}
  for line = line1, line2 do
    local txt = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    local idx = string.find(txt, vim.fn.getreg('/'))
    while idx do
      local ending = idx + string.len(vim.fn.getreg('/')) - 1
      if ending > idx then
        table.insert(hits, string.sub(txt, idx, ending))
      else
        ending = ending + 1
      end
      if vim.fn.getreg('[0]') == '^' then
        break
      end
      idx = string.find(txt, vim.fn.getreg('/'), ending)
    end
  end
  if #hits > 0 then
    reg = reg == '' and '+' or reg
    vim.fn.setreg(reg, table.concat(hits, '\n') .. '\n')
  else
    print('No hits')
  end
end

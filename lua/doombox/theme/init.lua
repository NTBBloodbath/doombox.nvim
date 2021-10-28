-- @class theme
local theme = {}

local function apply_highlight(group, colors)
  if colors.link then
    vim.cmd(string.format("hi! link %s %s", group, colors.link))
    return
  end

  local bg = colors.bg and "guibg=" .. colors.bg or "guibg=NONE"
  local fg = colors.fg and "guifg=" .. colors.fg or "guifg=NONE"
  local sp = colors.sp and "guisp=" .. colors.sp or "guisp=NONE"
  local gui = colors.style and "gui=" .. colors.style or "gui=NONE"
  vim.cmd(string.format("hi %s %s %s %s %s", group, bg, fg, sp, gui))
end

theme.setup = function(user_configs)
  local config = require("doombox.config").set(user_configs or {})

  -- Theme colors
  local c = require("doombox.colors").setup(config)
  local cb = c.base

  -- Highlighting groups
  local groups = {}
  groups.plugins = {}

  groups.base = {
    Normal = { fg = cb.fg, bg = cb.bg },
    NormalPopup = { fg = cb.fg, bg = cb.bg_popup },
    NormalPopover = { fg = cb.fg, bg = cb.bg_popup },
    NormalPopupPrompt = { fg = cb.fg, bg = cb.bg_highlight, style = "bold" },
    NormalPopupSubtle = { fg = cb.fg_alt, bg = cb.bg_popup },
    EndOfBuffer = { fg = cb.bg, bg = cb.bg },

    Visual = { bg = cb.bg_visual },
    VisualBold = { bg = cb.bg_visual, style = "bold" },

    LineNr = { fg = cb.grey, bg = cb.bg },
    Cursor = { fg = "#78a4c1" },
    CursorLine = { bg = cb.bg_highlight },
    CursorLineNr = { fg = cb.fg, bg = cb.bg_highlight },
    CursorColumn = { bg = cb.bg_highlight },

    Folded = { fg = cb.grey, bg = cb.bg_highlight },
    FoldColumn = { fg = cb.fg_alt, cb.bg },
    SignColumn = { bg = cb.bg },
    ColorColumn = { cb.bg_highlight },

    IndentGuide = { fg = cb.grey },
    IndentGuideEven = { link = "IndentGuide" },
    IndentGuideOdd = { link = "IndentGuide" },

    TermCursor = { fg = cb.fg, style = "reverse" },
    TermNormal = { link = "Normal" },
    TermNormalNC = { link = "TermNormal" },

    WildMenu = { fg = cb.fg, bg = cb.bg_visual },
    Separator = { fg = cb.border },
    VertSplit = { fg = cb.border, bg = cb.bg },
  }

  for _, group in pairs(groups) do
    for hl_group, colors in pairs(group) do
      apply_highlight(hl_group, colors)
    end
  end

  if config.coloring.cursor then
    vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"
  end
  if config.pumblend.enable then
    vim.opt.pumblend = config.pumblend.transparency_amount
  end
end

return theme

-- vim:sw=2:ts=2:sts=2

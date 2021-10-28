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

    TabLine = { fg = cb.fg, bg = cb.bg_alt, style = "bold" },
    TabLineSel = { fg = cb.blue, bg = cb.bg_highlight, style = "bold" },
    TabLineFill = { bg = cb.bg_dark, style = "bold" },

    StatusLine = { fg = cb.fg, bg = cb.bg_dark },
    StatusLineNC = { fg = cb.fg_alt, bg = cb.bg_popup },
    StatusLinePart = { fg = cb.fg_alt, bg = cb.bg_popup, style = "bold" },
    StatusLinePartNC = { fg = cb.fg_alt, bg = cb.bg_popup, style = "bold" },

    Pmenu = { fg = cb.fg, bg = cb.bg_highlight },
    PmenuSel = { fg = cb.black, bg = cb.blue },
    PmenuSelBold = { fg = cb.black, bg = cb.blue, style = "bold" },
    PmenuSbar = { bg = cb.bg_alt },
    PmenuThumb = { bg = cb.fg },

    Search = { fg = cb.fg, bg = cb.bg_visual, style = "bold" },
    Substitute = { fg = cb.red, style = "strikethrough,bold" },
    IncSearch = { fg = cb.fg, bg = cb.bg_visual, style = "bold" },
    IncSearchCursor = { style = "reverse" },

    Conceal = { fg = cb.grey, style = "none" },
    SpecialKey = { fg = cb.violet, style = "bold" },
    NonText = { fg = cb.fg_alt, style = "bold" },
    MatchParen = { fg = cb.red, style = "bold" },
    Whitespace = { fg = cb.grey },

    Highlight = { bg = cb.bg_highlight },
    HighlightSubtle = { bg = cb.bg_highlight },
    LspHighlight = { bg = cb.bg_highlight, style = "bold" },

    Question = { fg = cb.green, style = "bold" },

    File = { fg = cb.fg },
    Directory = { fg = cb.violet, style = "bold" },
    Title = { fg = cb.violet, style = "bold" },

    Bold = { style = "bold" },
    Emphasis = { fg = cb.green, style = "bold" },
  }

  groups.syntax = {
    Tag = { fg = cb.blue, style = "bold" },
    Link = { fg = cb.green, style = "underline" },
    URL = { link = "Link" },
    Underlined = { fg = cb.blue, style = "underline" },

    Comment = { fg = cb.grey, style = config.styles.comments },
    CommentBold = { fg = cb.grey, style = "bold" },
    SpecialComment = { fg = cb.fg_alt, style = "bold" },

    Macro = { fg = cb.violet },
    Define = { fg = cb.violet, style = config.styles.includes },
    Include = { fg = cb.violet, style = config.styles.includes },
    PreProc = { fg = cb.violet, style = config.styles.includes },
    PreCondit = { fg = cb.violet, style = config.styles.includes },

    Label = { fg = cb.blue },
    Repeat = { fg = cb.blue },
    Keyword = { fg = cb.blue },
    KeywordBuiltin = { fg = cb.blue, style = "bold" },
    Operator = { fg = cb.blue },
    Delimiter = { link = "Operator" },
    Statement = { fg = cb.blue },
    Exception = { fg = cb.blue },
    Conditional = { fg = cb.blue },

    VariableBuiltin = { fg = cb.violet, style = "bold" },
    Constant = { fg = cb.violet, style = config.styles.constants },

    Number = { fg = cb.orange },
    Float = { link = "Number" },
    Boolean = { fg = cb.orange, style = "bold" },
    Enum = { fg = cb.orange },

    String = { fg = cb.green },
    StringDelimiter = { link = "Delimiter" },
    Character = { fg = cb.violet, style = "bold" },
    SpecialChar = { fg = cb.magenta, style = "bold" },

    Field = { fg = cb.violet },
    Argument = { fg = cb.magenta, style = config.styles.parameters },
    Attribute = { fg = cb.magenta },
    Identifier = { fg = cb.magenta },
    Property = { fg = cb.magenta },
    Function = { fg = cb.magenta, style = config.styles.functions },
    FunctionBuiltin = { fg = cb.magenta, style = "bold" },
    Method = { fg = cb.magenta },

    Type = { fg = cb.yellow },
    Typedef = { fg = cb.blue },
    TypeBuiltin = { fg = cb.yellow, style = "bold" },
    Class = { fg = cb.blue },
    StorageClass = { link = "Class" },
    Structure = { fg = cb.blue },

    Regexp = { fg = cb.green, style = "bold" },
  }

  groups.text_messages = {
    TextNormal = { fg = cb.fg },
    TextInfo = { fg = cb.blue },
    TextSuccess = { fg = cb.green },
    TextWarning = { fg = cb.yellow },
    TextDebug = { fg = cb.orange },
    TextError = { fg = cb.red },
    TextSpecial = { fg = cb.violet },
    TextMuted = { fg = cb.grey },

    Msg = { link = "TextSuccess" },
    MoreMsg = { link = "TextInfo" },
    WarningMsg = { link = "TextWarning" },
    Error = { link = "TextError" },
    ErrorMsg = { link = "TextError" },
    ModeMsg = { link = "TextSpecial" },
    Todo = { fg = cb.yellow, style = "bold" },
  }

  groups.diff = {
    DiffAdd = { bg = c.diff.add },
    DiffChange = { bg = c.diff.change },
    DiffText = { bg = cb.fg_alt },
    DiffDelete = { bg = c.diff.delete },

    DiffAdded = { fg = c.diff.add, bg = c.diff.add },
    DiffModified = { fg = c.diff.change, bg = c.diff.change },
    DiffRemoved = { fg = c.diff.delete, bg = c.diff.delete },

    DiffAddedGutter = { fg = c.diff.add, style = "bold" },
    DiffModifiedGutter = { fg = c.diff.change, style = "bold" },
    DiffRemovedGutter = { fg = c.diff.delete, style = "bold" },

    DiffAddedGutterLineNr = { fg = c.diff.add },
    DiffModifiedGutterLineNr = { fg = c.diff.change },
    DiffRemovedGutterLineNr = { fg = c.diff.delete },
  }

  groups.markdown = {
    markdownCode = { bg = cb.bg_highlight },
    markdownCodeBlock = { bg = cb.bg_highlight },
    markdownH1 = { link = "Bold" },
    markdownH2 = { link = "Bold" },
    markdownLinkText = { style = "underline" },
  }

  ----- PLUGINS ---------------------------------
  if config.plugins_integrations.indent_blankline then
    groups.plugins = vim.tbl_extend("force", groups.plugins, {
      IndentBlanklineChar = {fg="#3f444a"},
      IndentBlanklineContextChar ={fg=cb.grey,style="nocombine"},
      IndentBlanklineSpaceChar ={fg=cb.grey,style="nocombine"},
      IndentBlanklineSpaceCharBlankline ={fg=cb.grey,style="nocombine"},
    })
  end

  ----- Apply highlighting ----------------------
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

  if config.coloring.terminal then
    local term_colors = {
      cb.bg,
      cb.red,
      cb.green,
      cb.orange,
      cb.blue,
      cb.magenta,
      cb.cyan,
      cb.fg,
      cb.grey,
      cb.red,
      cb.green,
      cb.yellow,
      cb.blue,
      cb.violet,
      cb.cyan,
      cb.white,
    }
    for i = 0, 15 do
      vim.g["terminal_color_" .. i] = term_colors[i + 1]
    end
    vim.g.terminal_color_background = cb.bg_alt
    vim.g.terminal_color_foreground = cb.fg_alt
  end
end

return theme

-- vim:sw=2:ts=2:sts=2

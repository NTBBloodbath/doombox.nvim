-- @class colors
local colors = {}

local utils = require("doombox.utils")

colors.setup = function(config)
  config = config or require("doombox.config").configuration

  -- Base colors
  local base = {
    none = "NONE",
    bg = config.transparent_background and "NONE" or "#22262a",
    bg_dark = utils.darken("#22262a", 0.2),
    bg_highlight = utils.lighten("#22262a", 0.2),
    fg = "#c7c0b3",
    fg_alt = utils.darken("#c7c0b3", 0.15),
    grey = "#868C96",
    red = "#f46a66",
    green = "#a0ba65",
    orange = "#e0874b",
    yellow = "#e2b269",
    blue = "#67aec9",
    cyan = "#67c6c0",
    magenta = "#cc7fbc",
    light_magenta = utils.lighten("#cc7fbc", 0.2),
    violet = "#be93be",
    dark_violet = utils.darken("#be93be", 0.1),
    white = "#e6dbc5",
  }

  base.border = base.grey

  -- Additional background colors
  base.bg_popup = base.bg_dark
  base.bg_visual = utils.darken(base.blue, 0.4)
  base.bg_sidebar = config.darken_sidebars and base.bg_dark or base.bg
  base.bg_float = config.darken_floats and base.bg_dark or base.bg

  -- Diff colors, used by Git-related plugins
  local diff = {
    add = utils.darken(base.green, 0.15),
    change = utils.darken(base.orange, 0.15),
    delete = utils.darken(base.red, 0.15),
  }

  return {
    base = base,
    diff = diff,
  }
end

return colors

-- @class doombox
local doombox = {}

doombox.load_colorscheme = function()
  require("doombox.theme").setup()
end

return doombox

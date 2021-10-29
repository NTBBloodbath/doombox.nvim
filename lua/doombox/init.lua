-- @class doombox
local doombox = {}

doombox.load_colorscheme = function()
  require("doombox.theme").setup()
end

doombox.setup = function(user_configs)
  require("doombox.config").set(user_configs or {})
end

return doombox

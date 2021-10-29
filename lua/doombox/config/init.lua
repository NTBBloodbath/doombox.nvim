--- @class config
local config = {}

config.configuration = {
  darken_sidebars = true,
  darken_floats = true,
  transparent_background = false,
  coloring = {
    cursor = true,
    terminal = true,
  },
  styles = {
    comments = nil, -- "bold" | "italic" | nil
    functions = nil, -- "bold" | "italic" | nil
    parameters = nil, -- "bold" | "italic" | nil
    includes = "bold", -- "bold" | "italic" | nil
    constants = "bold", -- "bold" | "italic" | nil
  },
  pumblend = {
    enable = true,
    transparency_amount = 20,
  },
  plugins_integrations = {
    barbar = true,
    dashboard = true,
    gitsigns = true,
    indent_blankline = true,
    neogit = true,
    neorg = true,
    netrw = true,
    nvim_tree = true,
    startify = true,
    telescope = false,
    treesitter = true,
    vim_illuminate = true,
    whichkey = true,
  },
}

--- Set user-defined configurations
--- @param user_configs table
--- @return table
config.set = function(user_configs)
  vim.validate({ user_configs = { user_configs, "table" } })

  config.configuration = vim.tbl_deep_extend("force", config.configuration, user_configs)
  return config.configuration
end

return config

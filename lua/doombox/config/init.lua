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
    comments = "none",   -- "bold" | "italic" | "none"
    functions = "none",  -- "bold" | "italic" | "none"
    parameters = "none", -- "bold" | "italic" | "none"
    includes = "bold",   -- "bold" | "italic" | "none"
    constants = "bold",  -- "bold" | "italic" | "none"
  },
  pumblend = {
    enable = true,
    transparency_amount = 20,
  },
  integrations = {
    dashboard = true,
    gitsigns = true,
    indent_blankline = true,
    neogit = true,
    neorg = true,
    nvim_tree = true,
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
end

return config

if vim.g.colors_name then
  vim.cmd("hi clear")
end
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g["colors_name"] = "doombox"

package.loaded["doombox"] = nil
package.loaded["doombox.config"] = nil
package.loaded["doombox.colors"] = nil
package.loaded["doombox.theme"] = nil
require("doombox").load_colorscheme()

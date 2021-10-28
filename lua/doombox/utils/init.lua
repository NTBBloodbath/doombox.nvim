---[[------------------------]]---
--       COLOR UTILITIES        --
---]]------------------------[[---

-- @class utils
local utils = {}

-------------------------------------------------------------------------------
-- Functions {{{

-- Convert RGB to Hex color.
-- @param r Red value
-- @param g Green value
-- @param b Blue value
-- @return HEX color, e.g. '#1E1E1E'
local function rgb_to_hex(r, g, b)
	return '#' .. string.format('%02X%02X%02X', r, g, b)
end

-- Convert Hex to RGB color.
-- @param color HEX color
-- @return RGB color, e.g. {30, 30, 30}
local function hex_to_rgb(color)
	color = color:gsub('#', '')
	return {
		tonumber('0x' .. string.sub(color, 1, 2)),
		tonumber('0x' .. string.sub(color, 3, 4)),
		tonumber('0x' .. string.sub(color, 5, 6)),
	}
end

-- }}}
-------------------------------------------------------------------------------
-- Composed functions {{{

utils.lighten = function(color, percentage)
	local amount = percentage == nil and 5.0 or percentage

	if amount < 1.0 then
		amount = 1.0 + amount
	else
		amount = 1.0 + (amount / 100.0)
	end

	-- Let's pass amount variable to Neovim so we can use
	-- the Neovim map function
	vim.g.amount = amount

	local rgb = hex_to_rgb(color)
	rgb = vim.fn.map(rgb, 'v:val * amount')
	-- Let's delete the g:amount variable since we don't need it anymore
	vim.cmd('unlet g:amount')

	rgb = vim.fn.map(rgb, 'v:val > 255.0 ? 255.0 : v:val')
	rgb = vim.fn.map(rgb, 'float2nr(v:val)')
	local hex = rgb_to_hex(rgb[1], rgb[2], rgb[3])

	return hex
end

utils.darken = function(color, percentage)
	local amount = percentage == nil and 5.0 or percentage

	if amount < 1.0 then
		amount = 1.0 - amount
	else
		amount = 1.0 - (amount / 100.0)
	end
	if amount < 0.0 then
		amount = 0.0
	end

	-- Let's pass amount variable to Neovim so we can use
	-- the Neovim map function
	vim.g.amount = amount

	local rgb = hex_to_rgb(color)
	rgb = vim.fn.map(rgb, 'v:val * amount')
	-- Let's delete the g:amount variable since we don't need it anymore
	vim.cmd('unlet g:amount')

	rgb = vim.fn.map(rgb, 'v:val > 255.0 ? 255.0 : v:val')
	rgb = vim.fn.map(rgb, 'float2nr(v:val)')
	local hex = rgb_to_hex(rgb[1], rgb[2], rgb[3])

	return hex
end

local function interpolate(start, _end, amount)
	local diff = _end - start
	return start + (diff * amount)
end

utils.mix = function(first, second, percentage)
	local amount = percentage == nil and 0.0 or percentage

	local first_rgb = hex_to_rgb(first)
	local second_rgb = hex_to_rgb(second)

	local r = interpolate(first_rgb[1], second_rgb[1], amount)
	local g = interpolate(first_rgb[2], second_rgb[2], amount)
	local b = interpolate(first_rgb[3], second_rgb[3], amount)

	return rgb_to_hex(r, g, b)
end

-- }}}

utils.live_reload = function()
  vim.cmd([[
    augroup DoomBox
      autocmd!
      autocmd BufWritePost */lua/doombox/** nested colorscheme doombox
    augroup end
  ]])
end

return utils

-- vim: fdm=marker

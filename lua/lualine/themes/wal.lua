-- Copyright (c) 2021-2023 nrv
-- GPLv3 license, see LICENSE for more details.

local util = require 'lualine-wal.util'

local lualine_require = require 'lualine_require'
local modules = lualine_require.lazy_require {
  utils_notices = 'lualine.utils.notices',
}

local XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME'
  or (util.join_path { os.getenv 'HOME', '.cache' })
local wal_colors_module_path =
  util.join_path { XDG_CACHE_HOME, 'wal', 'colors.lua' }

local ok, colors = pcall(dofile, wal_colors_module_path)
if not ok then
  modules.utils_notices.add_notice(
    'lualine.nvim: ' .. wal_colors_module_path .. ' not found'
  )
  return
end

local lightened_bg_color = util.lighten(colors.background, 2, '#000000')

return {
  normal = {
    a = { fg = colors.background, bg = colors.color2, gui = 'bold' },
    b = { fg = colors.foreground, bg = lightened_bg_color },
    c = { fg = colors.foreground, bg = lightened_bg_color },
  },
  insert = { a = { fg = colors.background, bg = colors.color3, gui = 'bold' } },
  visual = { a = { fg = colors.background, bg = colors.color4, gui = 'bold' } },
  replace = {
    a = { fg = colors.background, bg = colors.color1, gui = 'bold' },
  },
  inactive = {
    a = { fg = colors.foreground, bg = colors.background, gui = 'bold' },
    b = { fg = colors.foreground, bg = colors.background },
    c = { fg = colors.foreground, bg = colors.background },
  },
}

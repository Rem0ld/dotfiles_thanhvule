_G.global = {}

--- Initialize icons used throughout the user interface
function global.initialize_icons()
  global.icons = require("v.core.icons.nerd_font")
  global.text_icons = require("v.core.icons.text")
end

--- Get an icon from `lspkind` if it is available and return it
-- @param kind the kind of icon in `lspkind` to retrieve
-- @return the icon
function global.get_icon(kind)
  local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
  if not global[icon_pack] then global.initialize_icons() end
  return global[icon_pack] and global[icon_pack][kind] or ""
end

return global

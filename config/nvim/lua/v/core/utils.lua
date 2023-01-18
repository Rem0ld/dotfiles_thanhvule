local utils = {}

function utils.capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

function utils.is_os_darkmode()
	return true
	-- return utils.capture("gsettings get org.gnome.desktop.interface color-scheme"):find("dark")
end

return utils

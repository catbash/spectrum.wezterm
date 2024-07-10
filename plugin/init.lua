local wz = require("wezterm")

local spectrum = {}

local function spectrum_step(opacity, rgb)
	if opacity == nil then
		opacity = tostring(1)
	end
	if rgb == nil then
		return "rgba(255,255,255,1)"
	end
	return "rgba("
		.. tostring(rgb.r)
		.. ","
		.. tostring(rgb.g)
		.. ","
		.. tostring(rgb.b)
		.. ","
		.. tostring(opacity)
		.. ")"
end

local function tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then
		return title
	end
	return "[" .. tostring(tab.tab_index) .. "]"
end

spectrum.apply_to_config = function(c, args)
	c.use_fancy_tab_bar = false
	local default_colors = {
		spectrum = {
			r = 255,
			g = 255,
			b = 255,
		},
	}

	if args == nil then
		args = default_colors
	end

	wz.on("format-tab-title", function(tab, tabs, _, conf, _, max_width)
		-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
		local title = " " .. tab_title(tab)
		-- local title = args.bg.r
		local index = tab.tab_index + 1

		local is_last_tab = false
		local palette = conf.resolved_palette

		local offset = #tostring(index)
		if index < #tabs then
			is_last_tab = true
		end

		if #title >= max_width or (#title > (max_width - offset) and is_last_tab) then
			title = wz.truncate_right(title, max_width - offset - 1) .. "…"
		end

		local bg = spectrum_step(1 - ((1 / (#tabs + 2)) * (index + 1)), args.spectrum)
		-- colour alpha doesn't affect fg
		local fg = palette.tab_bar.inactive_tab.fg_color
		if tab.is_active then
			fg = palette.tab_bar.active_tab.fg_color
			bg = spectrum_step(1, args.spectrum)
		end

		title = title .. " "

		return {
			{ Background = { Color = bg } },
			{ Foreground = { Color = fg } },
			{ Text = title },
		}
	end)
end

return spectrum

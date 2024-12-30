local wz = require("wezterm")

local spectrum = {}

spectrum.step = function(opts)
  opts = opts or {}
  opts.opacity = opts.opacity or 1
  opts.rgb = opts.rgb or {
    r = 255,
    g = 255,
    b = 255,
  }

  return 'rgba('
    .. opts.rgb.r .. ','
    .. opts.rgb.g .. ','
    .. opts.rgb.b .. ','
    .. opts.opacity .. ')'
end

spectrum.title = function(tab)
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end
  return '[' .. tab.tab_index .. ']'
end

spectrum.apply_to_config = function(c, opts)
  c.use_fancy_tab_bar = false -- spectrum does not work with fancy tab bar enabled
  opts = opts or {}
  opts.bg = opts.bg or {
    r = 255,
    g = 255,
    b = 255,
  }
  opts.fg = opts.fg or {}
  opts.fg.active = opts.fg.active or '#000000'
  opts.fg.inactive = opts.fg.inactive or '#888888'

  wz.on('format-tab-title', function(tab, tabs, _, config, _, max_width)
    -- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
    local title = spectrum.title(tab)
    local index = tab.tab_index + 1

    local palette = config.resolved_palette

    local bg = spectrum.step({
      opacity = 1 - ((1 / (#tabs + 2)) * (index + 1)),
      rgb = opts.bg,
    })
    local fg = palette.tab_bar.inactive_tab.fg_color or opts.fg.inactive

    if tab.is_active then
      fg = palette.tab_bar.active_tab.fg_color or opts.fg.active
      bg = spectrum.step({
        opacity = 1,
        rgb = opts.bg,
      })
      local pane = tab.active_pane
      if pane.is_zoomed then
        title = '[z] ' .. title
      end
    end

    -- truncate title if needed
    local offset = #tostring(index)
    if #title >= max_width then
      title = wz.truncate_right(title, max_width - offset - 2) .. "…"
    end

    return {
      { Background = { Color = bg } },
      { Foreground = { Color = fg } },
      { Text = ' ' .. title .. ' ' },
    }
  end)
end

return spectrum

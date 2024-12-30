### `spectrum.wezterm`

![demo.gif](https://github.com/catbash/spectrum.wezterm/blob/main/img/demo.gif?raw=true)

A step-gradient effect for the [wezterm](https://github.com/wez/wezterm) tab bar

### ⚙️

Add the following to your `wezterm.lua` file:
``` lua
local wz = require("wezterm")
local spectrum = wz.plugin.require("https://github.com/catbash/spectrum.wezterm")
local opts = {
  bg = {
    r = 137,
    g = 180,
    b = 250,
  },
  fg = {
    inactive = '#ffffff',
    active = '#888888',
  },
}
spectrum.apply_to_config(config, opts)
```

Spectrum will automatically attempt to apply the resolved palette's `tab_bar.inactive_tab.fg_color` and `tab_bar.active_tab.fg_color` settings if available, or you can set them using `opts.fg.inactive` and `opts.fg.active` as shown in the example. If both are set, the resolved palette will override the local opts.

<details>
<summary>Example Colours Config</summary>

``` lua
local wz = require("wezterm")
local config = wz.config_builder()
local hex_white = '#ffffff'
config.colors = {
    tab_bar = {
        active_tab = {
            fg_color = hex_white,
            -- other settings ...
        },
        inactive_tab = {
            fg_color = hex_white,
            -- other settings ...
        },
    },
}
```
</details>

### References

[wezterm.plugin](https://github.com/wez/wezterm/commit/e4ae8a844d8feaa43e1de34c5cc8b4f07ce525dd) (commit `e4ae8a8`)

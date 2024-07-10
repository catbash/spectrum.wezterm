### `spectrum.wezterm`

![demo.gif](https://github.com/catbash/spectrum.wezterm/blob/main/img/demo.gif?raw=true)

A step-gradient effect for the wezterm tab bar

### ⚙️

Add the following to your `wezterm.lua` file:
``` lua
local wz = require("wezterm")
local spectrum = wz.plugin.require("https://github.com/catbash/spectrum.wezterm")
local spectrum_args = {
        spectrum = {
                r = 137,
                g = 180,
                b = 250,
        },
}
spectrum.apply_to_config(config, spectrum_args)
```

Note that spectrum only modifies the background colour for inactive tabs to create the step gradient. You will need to set the inactive tab fg and active tab bg and fg colours as usual.

<details>
<summary>Example Colours Config</summary>

``` lua
local config = wz.config_builder()
local hex_white = '#ffffff'
config.colors = {
	tab_bar = {
		background = "transparent",
		active_tab = {
			bg_color = "rgb(137,180,250)",
			fg_color = hex_white,
		},
		inactive_tab = {
			bg_color = "transparent",
			fg_color = hex_white,
		},
		inactive_tab_hover = {
			bg_color = "transparent",
			fg_color = hex_white,
		},
		new_tab = {
			bg_color = "transparent",
			fg_color = hex_white,
		},
		new_tab_hover = {
			bg_color = "transparent",
			fg_color = hex_white,
		},
	},
}
```
</details>

### References

[wezterm.plugin](https://github.com/wez/wezterm/commit/e4ae8a844d8feaa43e1de34c5cc8b4f07ce525dd) (commit `e4ae8a8`)

### `spectrum.wezterm`

![demo.gif](https://github.com/catbash/spectrum.wezterm/blob/main/img/demo.gif?raw=true)

A step-gradient effect for the wezterm tab bar

### 🔧

Add the following to your `wezterm.lua` file:
``` lua
local wz = require("wezterm")
local spectrum = wz.plugin.require("https://github.com/catbash/spectrum.wezterm")
spectrum.apply_to_config(config)
```

You can specify a custom gradient base colour in `rgb` format:
``` lua
local spectrum_args = {
        spectrum = {
                r = 137,
                g = 180,
                b = 250,
        },
}
spectrum.apply_to_config(config, spectrum_args)
```

### References

[wezterm.plugin](https://github.com/wez/wezterm/commit/e4ae8a844d8feaa43e1de34c5cc8b4f07ce525dd) (commit `e4ae8a8`)

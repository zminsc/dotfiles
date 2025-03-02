-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "Tokyo Night"
config.font_size = 17.0

config.background = {
  {
    source = {
      File = wezterm.config_dir .. "/warawara.png",
    },
  },
}

return config

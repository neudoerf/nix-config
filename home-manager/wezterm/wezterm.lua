local wezterm = require 'wezterm'

local config = {}

config.color_scheme = "Tokyo Night Storm"
config.default_cursor_style = "BlinkingUnderline"
config.enable_tab_bar = false
config.font = wezterm.font("IosevkaNeudoerf Nerd Font")
config.font_size = 14
config.use_fancy_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

return config

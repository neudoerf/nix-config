local wezterm = require 'wezterm'

local hostname = wezterm.hostname()

local config = {}

config.color_scheme = "Tokyo Night Storm"
config.default_cursor_style = "SteadyUnderline"
config.font = wezterm.font("IosevkaNeudoerf Nerd Font")
if hostname == "CPR02395L" then
  config.font_size = 12
  config.default_prog = { 'zsh' }
else
  config.font_size = 14
end
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

return config

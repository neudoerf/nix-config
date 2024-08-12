local wezterm = require 'wezterm'

local hostname = wezterm.hostname()

local config = {}

-- colors and fonts
config.color_scheme = "Tokyo Night"
config.default_cursor_style = "SteadyUnderline"
config.font = wezterm.font("IosevkaNeudoerf Nerd Font")
if hostname == "CPR02395L" then
  config.font_size = 12
  config.default_prog = { 'fish' }
else
  config.font_size = 14
end

-- window
config.window_decorations = "RESIZE"
config.window_frame = {
  font = wezterm.font({ family = "IosevkaNeudoerf Nerd Font", weight = "Bold" })
}
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

local function segments_for_right_status()
  return {
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status()

  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  local gradient_to = bg
  local gradient_from = gradient_to:lighten(0.2)

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config

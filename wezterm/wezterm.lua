local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.wsl_domains = {
  {
    name = "WSL:Ubuntu",
    distribution = "Ubuntu",
    default_cwd = "~",
  },
}

config.default_domain = "WSL:Ubuntu"

config.color_scheme = "Tokyo Night"
config.colors = {
  cursor_bg = "#c0caf5",
  cursor_fg = "#1a1b26",
  cursor_border = "#c0caf5",
  compose_cursor = "#7aa2f7",
}

config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "BIZ UDGothic",
})
config.font_size = 11.0
config.use_ime = true
config.treat_east_asian_ambiguous_width_as_wide = false
config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"

config.enable_tab_bar = false
config.audible_bell = "Disabled"
config.scrollback_lines = 10000
config.enable_scroll_bar = true

return config

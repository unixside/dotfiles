local wezterm = require('wezterm')

-- Wezterm Configuration
-- local theme = require('lua/rose-pine').main
local config = wezterm.config_builder()

config.font = wezterm.font "Aporetic Sans Mono"

config.font_size = 15.0
config.line_height = 1.0
config.enable_wayland = true

config.color_scheme = 'Modus-Operandi-Tinted'
-- config.color_scheme = 'iTerm2 Pastel Dark Background'
-- config.colors = theme.colors()
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Black Metal (Bathory) (base16)'
-- config.color_scheme = 'Modus-Vivendi-Tinted'
-- config.color_scheme = 'Modus Vivendi Tinted (Gogh)'
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.window_background_opacity = 1.0
config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = " NONE "

config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}

wezterm.on('update-right-status', function(window)
	local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

	-- Make it italic and underlined
	window:set_right_status(wezterm.format {
        { Attribute = { Italic = true } },
        { Attribute = { Intensity = "Normal" } },
        { Foreground = { Color = "#ffffff"} },
		{ Text = date .. " " },
	})
end)

return config

local wezterm = require('wezterm')

-- Wezterm Configuration
local theme = require('lua/rose-pine').main
local config = wezterm.config_builder()

config.font = wezterm.font "Iosevka NF"

config.font_rules = {
    {
        intensity = 'Normal',
        italic = true,
        font = wezterm.font {
            family = 'Iosevka NF',
            style = 'Italic'
        },
    },
}

config.font_size = 16.5
config.line_height = 1.0
config.enable_wayland = true
config.colors = theme.colors()
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
config.initial_rows = 30
config.initial_cols = 200
config.window_decorations = " NONE "

config.window_padding = {
	left = 24,
	right = 24,
	top = 24,
	bottom = 24,
}

wezterm.on('update-right-status', function(window, pane)
	local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

	-- Make it italic and underlined
	window:set_right_status(wezterm.format {
		{ Attribute = { Italic = true } },
		{ Attribute = { Intensity = "Normal" } },
		{ Text = date .. " " },
	})
end)

return config

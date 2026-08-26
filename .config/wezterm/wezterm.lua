local wezterm = require('wezterm')

-- Wezterm Configuration
-- local theme = require('lua/rose-pine').main
local config = wezterm.config_builder()

config.font = wezterm.font "Terminus (TTF)"

-- local colors = theme.colors()

config.font_size = 15.0
config.line_height = 1.0
config.enable_wayland = true
config.front_end = "WebGpu"
-- config.colors = colors
-- config.color_scheme = 'Modus-Vivendi'
-- config.color_scheme = 'iTerm2 Tango Dark'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Black Metal (Bathory) (base16)'
-- config.color_scheme = 'Modus-Vivendi-Tinted'
-- config.color_scheme = 'Modus Vivendi Tinted (Gogh)'
-- config.color_scheme = 'DWM rob (terminal.sexy)'
-- config.color_scheme = 'Ef-Dark'
config.color_scheme = 'Ibm3270 (Gogh)'
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.905
config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 100
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = " NONE "

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

config.keys = {
    { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    { key = '9', mods = 'ALT', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|WORKSPACES'} },
}

-- if config.window_background_opacity > 0 then
--     colors.background = '#000000'
-- end

wezterm.on('update-right-status', function(window)
    local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

    -- Make it italic and underlined
    window:set_right_status(wezterm.format {
        { Attribute = { Italic = true } },
        { Attribute = { Intensity = "Bold" } },
        -- { Foreground = { Color = "#ffffff"} },
        { Text = date .. " " },
    })
end)

return config

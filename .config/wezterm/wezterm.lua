local wezterm = require 'wezterm'
local act = wezterm.action
local colors = require('lua/rose-pine').colors()
local window_frame = require('lua/rose-pine').window_frame()

local config = {}

config.font = wezterm.font "JetBrains Mono"
config.font_size = 12
-- config.color_scheme = 'Gnometerm (terminal.sexy)'
-- config.color_scheme = 'OneDark (base16)'
-- config.color_scheme = 'matrix'
-- config.color_scheme = 'DWM rob (terminal.sexy)'
config.colors = colors
config.window_background_opacity = 1.0
config.window_frame = window_frame
config.line_height = 1.0
config.adjust_window_size_when_changing_font_size = false
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 400
config.front_end = "OpenGL"
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.enable_tab_bar = true
config.enable_wayland = false
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 56
config.use_fancy_tab_bar = false
config.initial_cols = 95
config.initial_rows = 23
config.window_padding = {
  left = 35,
  right = 35,
  top = 35,
  bottom = 35,
}

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

-- wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
--   local zoomed = ''
--   if tab.active_pane.is_zoomed then
--     zoomed = '[Z] '
--   end

--   local index = ''
--   if #tabs > 1 then
--     index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
--   end

--   return zoomed .. index .. tab.active_pane.title
-- end)

config.leader = { key = 'Space', mods = 'CTRL|SHIFT' }
config.keys = {
  -- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
  -- mode until we cancel that mode.
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  -- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
  -- mode until we press some other key or until 1 second (1000ms)
  -- of time elapses
  {
    key = 'a',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'activate_pane',
      timeout_milliseconds = 1000,
    },
  },


  -- ScrollByLine
  { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollByLine(1) },

}

config.key_tables = {
  -- Defines the keys that are active in our resize-pane mode.
  -- Since we're likely to want to make multiple adjustments,
  -- we made the activation one_shot=false. We therefore need
  -- to define a key assignment for getting out of this mode.
  -- 'resize_pane' here corresponds to the name="resize_pane" in
  -- the key assignments above.
  resize_pane = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

  -- Defines the keys that are active in our activate-pane mode.
  -- 'activate_pane' here corresponds to the name="activate_pane" in
  -- the key assignments above.
  activate_pane = {
    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },

    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },

    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },

    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
  },
}

return config


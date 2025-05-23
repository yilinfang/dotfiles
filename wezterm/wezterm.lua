local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = 'WebGpu'

config.font_size = 15.0
config.line_height = 1.0
config.font = wezterm.font_with_fallback {
  'JetMaple Mono',
  'Noto Color Emoji',
  'Symbols Nerd Font Mono',
}

config.initial_rows = 30
config.initial_cols = 120

config.enable_scroll_bar = false
config.use_fancy_tab_bar = true

config.color_scheme = 'Solarized Dark - Patched'
local solarized_dark_colors = wezterm.get_builtin_color_schemes()[config.color_scheme]

config.window_frame = {
  font_size = 15.0,
  active_titlebar_bg = solarized_dark_colors.ansi[1],
}

config.window_padding = {
  left = '8',
  right = '8',
  top = '8',
  bottom = '8',
}

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = solarized_dark_colors.background,
      fg_color = solarized_dark_colors.foreground,
    },
    inactive_tab = {
      bg_color = solarized_dark_colors.ansi[1],
      fg_color = solarized_dark_colors.brights[3],
    },
    inactive_tab_hover = {
      bg_color = solarized_dark_colors.ansi[5],
      fg_color = solarized_dark_colors.background,
    },
    inactive_tab_edge = solarized_dark_colors.brights[1],
    new_tab = {
      bg_color = solarized_dark_colors.ansi[1],
      fg_color = solarized_dark_colors.brights[3],
    },
    new_tab_hover = {
      bg_color = solarized_dark_colors.ansi[5],
      fg_color = solarized_dark_colors.background,
    },
  },
}

config.keys = {
  {
    key = 'Enter',
    mods = 'SUPER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  {
    key = 'Enter',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  {
    key = 'LeftArrow',
    mods = 'SUPER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },

  {
    key = 'RightArrow',
    mods = 'SUPER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },

  {
    key = 'UpArrow',
    mods = 'SUPER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },

  {
    key = 'DownArrow',
    mods = 'SUPER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },

  {
    key = 'LeftArrow',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },

  {
    key = 'RightArrow',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },

  {
    key = 'UpArrow',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },

  {
    key = 'DownArrow',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
}

return config

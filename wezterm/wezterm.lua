local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"

config.color_scheme = "iTerm2 Tango Dark"

config.font_size = 15.0
config.font = wezterm.font_with_fallback({
	"VictorMono Nerd Font",
	"Noto Color Emoji",
	"Symbols Nerd Font Mono",
})

config.initial_rows = 30
config.initial_cols = 120

config.enable_scroll_bar = true

config.window_frame = {
	font_size = 14.0,
}

config.window_padding = {
	left = 15,
	right = 20,
	top = 15,
	bottom = 0,
}

config.keys = {
	{
		key = "Enter",
		mods = "SUPER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "Enter",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "LeftArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},

	{
		key = "RightArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	{
		key = "UpArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},

	{
		key = "DownArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	{
		key = "LeftArrow",
		mods = "SUPER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},

	{
		key = "RightArrow",
		mods = "SUPER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},

	{
		key = "UpArrow",
		mods = "SUPER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},

	{
		key = "DownArrow",
		mods = "SUPER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
}

return config

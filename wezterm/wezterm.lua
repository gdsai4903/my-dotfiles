local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	macos_window_background_blur = 30,
	automatically_reload_config = true,
	window_close_confirmation = "NeverPrompt",
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "RESIZE",
	initial_cols = 150,
	initial_rows = 40,
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	default_cursor_style = "BlinkingBar",
	cursor_blink_rate = 800,
	animation_fps = 60,
	font_size = 13,
	font = wezterm.font("Cascadia Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	color_scheme = "Nord (Gogh)",
	enable_tab_bar = false,
	background = {
		{
			source = {
				File = "/Users/" .. os.getenv("USER") .. "/.config/wezterm/BG5.png",
			},
			hsb = {
				hue = 1.0,
				-- saturation = 0.22,
				brightness = 1.0,
			},
			-- attachment = { Parallax = 0.3 },
			-- width = "100%",
			-- height = "100%",
			opacity = 0.4,
		},
		{
			source = {
				Color = "#202234",
			},
			width = "100%",
			height = "100%",
			opacity = 0.7,
		},
	},
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
}
inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

config.keys = {
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.SendKey({
			key = "f",
			mods = "ALT",
		}),
	},
}

return config

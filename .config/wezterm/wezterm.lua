local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font_with_fallback({
	"Hurmit Nerd Font Mono",
	"FiraCode Nerd Font",
	"JetBrains Mono",
})

config.win32_system_backdrop = "Acrylic"
config.front_end = "Software"
config.term = "xterm-256color"
config.prefer_egl = true

config.default_domain = "WSL:Ubuntu"

config.window_decorations = "NONE"

config.audible_bell = "Disabled"

config.animation_fps = 1
config.cursor_blink_rate = 500

config.max_fps = 120
config.animation_fps = 1

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.5

config.adjust_window_size_when_changing_font_size = false

-- toggle function
wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local current_opacity = overrides.window_background_opacity

	if current_opacity == nil or current_opacity == 0.5 then
		overrides.window_background_opacity = 1.0
	else
		overrides.window_background_opacity = 0.5
	end

	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "O",
		mods = "ALT",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
	-- Move backward one word
	{
		key = "LeftArrow",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bb"),
	},
	-- Move forward one word
	{
		key = "RightArrow",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1bf"),
	},
}

config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#C5C9C7",
	background = "#14171d",

	cursor_bg = "#C5C9C7",
	cursor_fg = "#14171d",
	cursor_border = "#C5C9C7",

	selection_fg = "#C5C9C7",
	selection_bg = "#393B44",

	scrollbar_thumb = "#393B44",
	split = "#393B44",

	ansi = {
		"#14171d",
		"#C4746E",
		"#8A9A7B",
		"#C4B28A",
		"#8BA4B0",
		"#A292A3",
		"#8EA4A2",
		"#A4A7A4",
	},
	brights = {
		"#A4A7A4",
		"#E46876",
		"#87A987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#C5C9C7",
	},
}

return config

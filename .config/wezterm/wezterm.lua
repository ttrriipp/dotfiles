local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font_with_fallback({
	"Hurmit Nerd Font Mono",
	"FiraCode Nerd Font",
	"JetbrainsMono Nerd Font",
})

config.front_end = "Software"
config.term = "xterm-256color"
config.prefer_egl = true

config.default_domain = "WSL:Ubuntu"

config.window_decorations = "RESIZE"

config.audible_bell = "Disabled"

config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500

config.max_fps = 120
config.animation_fps = 1

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.adjust_window_size_when_changing_font_size = false

-- toggle function
wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local current_opacity = overrides.window_background_opacity

	if current_opacity == nil or current_opacity == 0.69 then
		overrides.window_background_opacity = 1.0
	else
		overrides.window_background_opacity = 0.69
	end

	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "O",
		mods = "ALT",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

return config

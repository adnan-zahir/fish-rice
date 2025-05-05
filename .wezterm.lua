local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local nvim = "/opt/homebrew/bin/nvim"

local wez_nvim_action = function(window, pane, action_wez, forward_key_nvim)
	local current_process = mux.get_window(window:window_id()):active_pane():get_foreground_process_name()
	if current_process == nvim then
		window:perform_action(forward_key_nvim, pane)
	else
		window:perform_action(action_wez, pane)
	end
end

wezterm.on("move-left", function(window, pane)
	wez_nvim_action(
		window,
		pane,
		act.ActivatePaneDirection("Left"), -- this will execute when the active pane is not a nvim instance
		act.SendKey({ key = "h", mods = "CTRL" }) -- this key combination will be forwarded to nvim if the active pane is a nvim instance
	)
end)

wezterm.on("move-right", function(window, pane)
	wez_nvim_action(window, pane, act.ActivatePaneDirection("Right"), act.SendKey({ key = "l", mods = "CTRL" }))
end)

wezterm.on("move-down", function(window, pane)
	wez_nvim_action(window, pane, act.ActivatePaneDirection("Down"), act.SendKey({ key = "j", mods = "CTRL" }))
end)

wezterm.on("move-up", function(window, pane)
	wez_nvim_action(window, pane, act.ActivatePaneDirection("Up"), act.SendKey({ key = "k", mods = "CTRL" }))
end)

-- you can add other actions, this unifies the way in which panes and windows are closed
-- (you'll need to bind <A-x> -> <C-w>q)
wezterm.on("close-pane", function(window, pane)
	wez_nvim_action(window, pane, act.CloseCurrentPane({ confirm = false }), act.SendKey({ key = "x", mods = "ALT" }))
end)

return {
	-- **Font Settings**
	font = wezterm.font("FiraCode Nerd Font"),
	-- font_size = 9.0,
	freetype_load_target = "Light", -- Optional for fine-tuned font rendering
	-- font_antialias = "Subpixel",
	-- font_hinting = "Full",

	-- **Letter Spacing and Line Height**
	line_height = 1.0, -- Default; adjust if needed
	adjust_window_size_when_changing_font_size = false,
	text_background_opacity = 1.0, -- Text opacity
	cell_width = 1.0, -- Adjust letter spacing (default)

	-- **Colors and Transparency**
	color_scheme = "Catppuccin Mocha",
	-- colors = {
	-- 	foreground = "#cdd6f4",
	-- 	background = "#1e1e2e",
	-- 	selection_fg = "#cdd6f4",
	-- 	selection_bg = "#414356",
	-- 	cursor_bg = "#cdd6f4",
	-- 	cursor_border = "#cdd6f4",
	-- 	cursor_fg = "#1e1e2e",
	-- 	ansi = { "#45475a", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#bac2de" },
	-- 	brights = { "#585b70", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#a6adc8" },
	-- 	indexed = { [16] = "#fab387", [17] = "#f5e0dc" },
	-- },
	window_background_opacity = 0.8, -- Match `alpha=0.8` in Foot

	-- **Cursor Configuration**
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",

	-- **Window Settings**
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	-- initial_cols = 80,
	-- initial_rows = 24,
	window_decorations = "NONE",
	enable_tab_bar = true, -- Disables tab bar if you prefer single windows
	use_fancy_tab_bar = false,

	-- **Terminal and Shell Settings**
	default_prog = { "/opt/homebrew/bin/fish", "-l" }, -- Match `term=tmux-256color`
	-- default_prog = { "/usr/bin/bash", "-l" }, -- Match `term=tmux-256color`
	set_environment_variables = {
		TERM = "tmux-256color",
		PATH = "/opt/homebrew/bin:/usr/local/bin:" .. os.getenv("PATH"), -- Add this line
	},

	-- **Key Bindings**
	keys = {
		{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
		{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-left" }) },
		{ key = "l", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-right" }) },
		{ key = "j", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-down" }) },
		{ key = "k", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-up" }) },
		{ key = "x", mods = "ALT", action = wezterm.action({ EmitEvent = "close-pane" }) },
	},

	-- **Mouse Settings**
	scrollback_lines = 1000,
}

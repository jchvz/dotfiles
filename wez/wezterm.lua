-- Presuppose that windows has the env var:
-- WEZTERM_CONFIG_FILE="\\wsl$\NixOS\home\john\dotfiles\wez\wezterm.lua"

local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.wsl_domains = {
	-- Nix
	{
		name = "WSL:NixOS",
		distribution = "NixOS",
		default_cwd = "/home/john",
	},
}

config.default_domain = "WSL:NixOS"

config.color_scheme = "Everforest Light Hard (Gogh)"
config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#0f0c29",
		"#302b64",
	},
}

return config

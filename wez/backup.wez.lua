local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.wsl_domains = {
	-- Nix
	{
		name = "WSL:NixOS",
		distribution = "NixOS",
	},
}

config.default_domain = "WSL:NixOS"

config.color_scheme = "EverGreen"

return config

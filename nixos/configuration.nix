{ config, lib, pkgs, ... }:
let
  customNeovim = import ./derivations/nvim.nix { inherit pkgs lib; };
in
{
  imports = [
    <nixos-wsl/modules>
  ];

  users.users.john = {
    shell = pkgs.fish;
  };

  nix.gc={
    automatic=true;
    dates="03:13"; #3h13m
    options="-d";
  };
  nixpkgs.config.allowUnfree=true;


  # builtlin programs
  programs = {
    fish = {
      enable=true;
      shellAbbrs={
        # Git
        gs="git status";
	gnew="git push --set-upstream origin (git branch --show-current)";

	# Nix
	nxc="sudo -E nvim /etc/nixos/configuration.nix";
	nxs="sudo nixos-rebuild switch";

	# Misc
	cat="bat";
  vim="nvim";
      };
    };
    fzf = {
      keybindings=true;
      fuzzyCompletion=true;
    };
    git = {
      enable=true;
      config = {
        init.defaultBranch="master";
      };
    };
    htop = {
      enable=true;
      settings={
        hide_kernel_threads=true;
	hide_userland_threads=true;
      };
    };
      #neovim = {
      #enable=true;
      #vimAlias=true;
    #};
    npm.enable=true;
    #ssh.enable=true;
  };




  # system packages
  environment.systemPackages = with pkgs; [
    bat
    go
    gcc
    zig
    nodejs
    gnumake
    ripgrep
    tree
    customNeovim
    zip
    unzip
    # language servers
    lua-language-server
    nil
  ];

  # env vars
  environment.variables = {
    XDG_CONFIG_HOME="$HOME/.config";
    EDITOR="nvim";
  };
  # https://github.com/nix-community/NixOS-WSL
  wsl.enable = true;
  wsl.defaultUser = "john";
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

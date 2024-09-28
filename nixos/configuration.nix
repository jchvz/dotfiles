{ lib, pkgs, ... }:
let
  #customNeovim = import ./derivations/nvim.nix { inherit pkgs lib; };
  patchTar = import ./utils/patchTar.nix { inherit pkgs; };
in
{
  imports = [
    <nixos-wsl/modules>
  ];

  users. users. john = {
    shell = pkgs.fish;
  };

  nix.gc = {
    automatic = true;
    dates = "03:13"; #3h13m
    options = "-d";
  };
  nixpkgs.config.allowUnfree = true;


  # builtlin programs
  programs = {
    fish = {
      enable = true;
      shellAliases = { };
      shellAbbrs = {
        # Git
        gs = "git status";
        gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        gnew = "git push --set-upstream origin (git branch --show-current)";
        gmods = "git submodule deinit -f .; git submodule update --init";
        cherry = "git cherry-pick";
        #pr_summary = "";

        # Nix
        nxc = "sudo -E nvim /etc/nixos/configuration.nix";
        nxs = "sudo nixos-rebuild switch";
        nxurl = "nix-prefetch-url";

        # Transparent replacements
        cat = "bat";
        vim = "nvim";
        grep = "rg";
        find = "fd";
      };
    };
    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    git = {
      enable = true;
      config = {
        init.defaultBranch = "master";
      };
    };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };
    #neovim = {
    #enable=true;
    #vimAlias=true;
    #};
    npm.enable = true;
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
    fd
    tree

    (patchTar.download {
      pname = "neovim";
      bname = "nvim";
      version = "0.10.1";
      sha256 = "14wp3y7p049zvs9h5k43dsix63hbnham5apq0bwq6q3zl40xwrs8";
      url = "https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz";
      buildInputs = [ pkgs.libgcc ];
    })


    #customNeovim
    zip
    unzip
    # language servers and formatters
    lua-language-server
    stylua
    nil
    nixpkgs-fmt
  ];

  # env vars
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    EDITOR = "nvim";
    BAT_THEME = "OneHalfLight";

    # Fzf config
    FZF_DEFAULT_COMMAND = "fd -H";
    FZF_DEFAULT_OPTS = "--height 100";
    FZF_CTRL_T_COMMAND = "fd -H";
    FZF_CTRL_T_OPTS = ";
      --preview 'bat -n --color=always --theme=OneHalfLight {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'";
    FZF_ALT_C_OPTS = "--preview 'tree -C {}'";
  };
  # https://github.com/nix-community/NixOS-WSL
  wsl.enable = true;
  wsl.defaultUser = "john";


  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

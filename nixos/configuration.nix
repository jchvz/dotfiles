{ pkgs, ... }:
let
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
      shellAliases = {
        git_log_pretty = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      shellAbbrs = {
        # Git
        gs = "git status";
        gl = "git_log_prety";
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
    (
      patchTar.download {
        bname = "bat";
        bpath = "bat";
        version = "v0.24.0";
        url = "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-gnu.tar.gz";
        sha256 = "0yn74pws9ry23vv1d2w1r6nh9jfmhzv3pjax9691py2vp18mvbqg";
        buildInputs = [ ];
      }
    )

    go
    gcc
    zig
    nodejs
    gnumake
    ripgrep
    fd
    tree

    (patchTar.download {
      bname = "nvim";
      bpath = "bin/nvim";
      version = "0.10.1";
      url = "https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz";
      sha256 = "14wp3y7p049zvs9h5k43dsix63hbnham5apq0bwq6q3zl40xwrs8";
      buildInputs = [ ];
    })


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

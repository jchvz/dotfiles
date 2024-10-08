{ lib, pkgs, ... }:
let
  derive = import ./utils/derive.nix {inherit pkgs lib;};
in
{
  imports = [
    <nixos-wsl/modules>
  ];

  users. users. john = {
    shell = pkgs.fish;
    extraGroups = ["docker"];
  };

  nix ={
    gc = {
      automatic = true;
      dates = "03:13"; #3h13m
      options = "-d";
    };
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  
  nixpkgs.config.allowUnfree = true;
 
  virtualisation.docker.enable=true;

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

        # Docker
        dps = "docker ps";

        # Lazy
        lzg = "lazygit";
        lzd = "lazydocker";

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
    #ssh.enable=true;
  };

  # system packages
  environment.systemPackages = with pkgs; [
    go
    gcc
    zig
    nodejs_18
    nodePackages.svelte-language-server
    gnumake
    tree
    zip
    unzip
    docker
    wget
    curl
    jq
    # Literally takes >30 mins
    (builtins.getFlake "github:helix-editor/helix").packages.${pkgs.system}.default
  
    (derive.go {
      owner = "swaggo";
      pname = "swag";
      version = "v1.8.12";
      repoHash = "sha256-2rnaPN4C4pn9Whk5X2z1VVxm679EUpQdumJZx5uulr4=";
      vendorHash = "sha256-mLMOArOz7TPYvHWtAtwCMV/LWMC8CkMDGFBDYW1Z4NM=";
      cmd = "cmd/swag";
    })

    (derive.go {
      owner = "wagoodman";
      pname = "dive";
      version = "v0.12.0";
      repoHash = "sha256-CuVRFybsn7PVPgz3fz5ghpjOEOsTYTv6uUAgRgFewFw=";
      vendorHash = "sha256-268qJPhGEd3BQdnalgHj102opOv7CV2Mkz1x+5Ztn/k=";
      cmd = ".";
    })

    (derive.go {
      owner = "jesseduffield";
      pname = "lazydocker";
      version = "v0.23.3";
      repoHash = "sha256-1nw0X8sZBtBsxlEUDVYMAinjMEMlIlzjJ4s+WApeE6o=";
      vendorHash = null;
      cmd = ".";
    })

    (derive.go{
      owner = "jesseduffield";
      pname = "lazygit";
      version = "v0.44.1";
      repoHash = "sha256-BP5PMgRq8LHLuUYDrWaX1PgfT9VEhj3xeLE2aDMAPF0=";
      vendorHash = null;
      cmd = ".";
    })

    (derive.rust {
      owner = "BurntSushi";
      pname = "ripgrep";
      version = "14.1.1";
      sha256 = "1s39cgazg9m5yrfyjh4qxgjwmvnn8znx8l09a6byh0zm31maf9c3";
    })

    # (derive.rust {
    #   owner = "helix-editor";
    #   pname = "helix";
    #   version = "v0.6.0";
    #   sha256 = "0hhcc9lvjxqipi48i1rhl6p86i5pjls4yk8l8wjba7qg3ai4xs87";
    #   buildInputs = [pkgs.more];
    # }).overrideAttrs (oldAttrs: {
    #   # cargo build on helix for some evil reason replaces `fd`
    #   postInstall = ''
    #     rm -f $out/bin/fd
    #   '';
    # })

    (derive.rust {
      owner = "sharkdp";
      pname = "fd";
      version = "v10.2.0";
      sha256 = "0hhcc9lvjxqipi48i1rhl6p86i5pjls4yk8l8wjba7qg3ai4xs87";
    })

    (derive.rust {
      owner = "sharkdp";
      pname = "bat";
      version = "v0.24.0";
      sha256 = "0922wccggbmxjz7am0da50bqfl2gmfsnw446s0gk7zlq94jfa66m";
      buildInputs = [
        # pkgs.more
        # pkgs.most
      ];
      testsToSkip = [
        # there are 15 bat integration tests that try to make use of a fancy function
        # `with_mocked_versions_of_more_and_most_in_path`. However, in nixos, those
        # mocked utils are not accessible during the test runtime. So the tests fail.
        "alias_pager_disable_long_overrides_short"
        "config_read_arguments_from_file"
        "env_var_bat_paging"
        "pager_arg_override_env_noconfig"
        "pager_arg_override_env_withconfig"
        "pager_basic"
        "pager_basic_arg"
        "pager_env_bat_pager_override_config"
        "pager_env_pager_nooverride_config"
        "pager_more"
        "pager_most_from_bat_pager_env_var"
        "pager_most_from_pager_arg"
        "pager_most_from_pager_env_var"
        "pager_most_with_arg"
        "pager_overwrite"
      ];
    })

    (derive.tar {
      pname = "neovim";
      bname = "nvim";
      version = "0.10.1";
      sha256 = "14wp3y7p049zvs9h5k43dsix63hbnham5apq0bwq6q3zl40xwrs8";
      url = "https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz";
      buildInputs = [ pkgs.libgcc ];
    })


    # language servers and formatters
    lua-language-server
    stylua
    nil
    nixpkgs-fmt
    gopls
    # (derive.go{
    #   pname = "tools";
    #   owner = "golang";
    #   version = "gopls/v0.16.2";
    #   repoHash = "sha256-amy00VMUcmyjDoZ4d9/+YswfcZ+1/cGvFsA4sAmc1dA=";
    #   vendorHash = "sha256-hvxH1aaaDy+ahkKiq6QCQXQpMrobq8jZSW2OrDtqm10=";
    #   cmd = "gopls/main.go";
    # })
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

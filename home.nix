{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kuba";
  home.homeDirectory = "/home/kuba";

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.PROMPT_COMMAND = { (pwd) }
      
      $env.config = { 
        show_banner: false 
        hooks: {
          pre_prompt: [{ ||
            if (which direnv | is-empty) {
              return
            }
            direnv export json | from json | default {} | load-env
          }]
        }
      }
      
      $env.PATH = ($env.PATH | 
       split row (char esep) |
       append /home/kuba/.cargo/bin
       )
    '';
  };

  programs.direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "adwaita-dark";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "block";
      };
      editor.soft-wrap.enable = true;
    };
  };

  programs.zathura = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Jakub Koňařík";
    userEmail = "kkonarikk@gmail.com";
  };

  programs.lf = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
  };
  
  programs.mpv = {
    enable = true;
  };
  
  programs.pandoc = {
    enable = true;
  };
  
  programs.zoxide = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [ "us" "cz" ];
      xkb-variant = [ "" "qwerty" ];
      xkb-options = [ "grp:win_space_toggle" ];
    };
  };

  # programs.firefox = {
  #   enable = true;
  # };
  
  # fzf
  # ouch
  # choose
  # wine
  # syncthing
  # zellij
  # gpg
  # please
  # edir


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kuba/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

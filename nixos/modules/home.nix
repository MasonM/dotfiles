{ config, pkgs, ... }:

{
  home = {
    username = "masonm";
    homeDirectory = "/home/masonm";

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };

  programs.git = {
    enable = true;
    includes = [{ path = "~/src/dotfiles/gitconfig"; }];
  };

  programs.atuin = {
    enable = true;
    settings = {
      update_check = false;
      search_mode = "skim";
      enter_accept = false;
      keymap_mode = "vim-insert";
      sync = {
        records = true;
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 0;
    historyLimit = 10000;
    prefix = "C-a";
    extraConfig = builtins.readFile ../configs/tmux.conf;
  };

  programs.home-manager.enable = true;
}

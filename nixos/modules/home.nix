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

  programs = {
    vim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        vimwiki
        syntastic
        tabular
        vim-unimpaired
      ];
      extraConfig = builtins.readFile ../configs/vimrc;
    };

    git = {
      enable = true;
      includes = [{ path = "~/src/dotfiles/gitconfig"; }];
    };

    atuin = {
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

    tmux = {
      enable = true;
      keyMode = "vi";
      escapeTime = 0;
      historyLimit = 10000;
      prefix = "C-a";
      extraConfig = builtins.readFile ../configs/tmux.conf;
    };

    home-manager.enable = true;
  };
}

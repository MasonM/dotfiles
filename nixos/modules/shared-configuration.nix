# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  time.timeZone = "America/Los_Angeles";

  services = {
    #xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    # Get /bin/bash working: https://unix.stackexchange.com/a/788456
    envfs.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  users.users.masonm = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    steam.enable = true;
    ssh.startAgent = true;
    bash.interactiveShellInit = ''
      # append to the history file, don't overwrite it
      shopt -s histappend
      set -o vi
      export EDITOR='vim'
    '';
  };
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # general CLI tools
    wget
    fzf
    gnupg
    jq
    bat
    unzip
    ripgrep
    btop
    lshw
    inetutils

    # documents
    ghostscript
    libreoffice
    hunspell
    hunspellDicts.en_US
    lyx
    (texliveBasic.withPackages (ps: with ps; [
      # resume
      breakurl
      enumitem
      microtype
      lmodern
      xkeyval
    ]))

    # system
    borgbackup
    lm_sensors

    # development
    gnumake
    subversion
    delta
    gh
    mtr
    devenv
    pkgs.unstable.claude-code
    cloc

    # Kubernetes
    skopeo
    kubectl
    k3d
    minikube
    kind
    kubernetes-helm

    # languages
    go
    delve
    python3
    php

    # desktop
    keepassxc
    vscode
    workrave
    zoom-us
    kdePackages.partitionmanager
    kdePackages.spectacle

    # desktop - internet
    google-chrome
    thunderbird
    transmission_4-qt

    # desktop - multimedia
    vlc
    gimp3
    yacreader
    libsForQt5.qt5.qtimageformats # webp support for yacreader
    spotify
  ];
}


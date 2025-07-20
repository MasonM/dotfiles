# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Workaround system freeze:
      # https://wiki.nixos.org/wiki/AMD_GPU#System_Hang_with_Vega_Graphics_(and_select_GPUs)
      ./modules/amdgpu_patch.nix
    ];
  boot.kernelPackages = pkgs.linuxPackages_6_13;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.luks.devices.crypted.device = "/dev/disk/by-uuid/1cd25d93-9e12-4bd6-8840-1541e50b439a";
  };

  time.timeZone = "America/Los_Angeles";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

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
    vim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.vim-full;
    };
  };
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # general CLI tools
    wget
    atuin
    tmux
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
    git
    subversion
    delta
    gh
    mtr
    devenv
    unstable.claude-code

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

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}


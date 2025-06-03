# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/amdgpu_patch.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_6_13;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    # https://discussion.fedoraproject.org/t/freezing-amd-gpu-dual-boot-windows/120171/4
    #"amdgpu.ppfeaturemask=0xfff7ffff"
    #"amd_pstate=active"
    # https://www.reddit.com/r/linux4noobs/comments/1ahb8pf/what_exactly_does_amdgpuppfeaturemask0xfffd3fff_do/
    #"amdgpu.ppfeaturemask=0xfffd3fff"
    # https://gitlab.freedesktop.org/drm/amd/-/issues/3863#note_2723629
    #"amdgpu.gfxoff=1"
    # https://bbs.archlinux.org/viewtopic.php?pid=2221728#p2221728
    #"amdgpu.dcdebugmask=0x10"
    # Workaround for https://gitlab.freedesktop.org/drm/amd/-/issues/3863
    # https://old.reddit.com/r/linux_gaming/comments/2f79obl/amdgpu_users_avoid_updating_linuxfirmware_right/
    #"pcie_port_pm=off"
  ];
  boot.initrd.luks.devices.crypted.device = "/dev/disk/by-uuid/1cd25d93-9e12-4bd6-8840-1541e50b439a";

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services = {
    #xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.masonm = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker"
    ];
    shell = pkgs.zsh;
    #packages = with pkgs; [
    #  tree
    #];
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    steam.enable = true;
    vim.enable = true;
    ssh.startAgent = true;
  };
  virtualisation.docker.enable = true;

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

    # system
    borgbackup
    lm_sensors

    # development
    gnumake
    git
    delta
    gh

    # languages
    go
    python3
    php

    # desktop
    keepassxc
    vscode
    libreoffice
    workrave
    lyx
    kdePackages.partitionmanager

    # desktop - internet
    google-chrome
    thunderbird
    transmission_4-qt

    # desktop - multimedia
    vlc
    gimp3
    yacreader
    libsForQt5.qt5.qtimageformats # webp support for yacreader
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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


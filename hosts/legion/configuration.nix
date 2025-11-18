# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "legion"; # Define your hostname.
  
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;  # Easiest to use and most distros use this by default.
      # wifi.backend = "iwd";
    };

    wireless.iwd.enable = false;

    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  systemd.services.NetworkManager.wantedBy = lib.mkForce [ "multi-user.target" ];

  # Set your time zone.
  time.timeZone = "Asia/Karachi";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  #  console = {
  #    font = "Lat2-Terminus16";
  #    keyMap = "us";
  #    useXkbConfig = true; # use xkb.options in tty.
  #  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Adding security
  security = {
    sudo.wheelNeedsPassword = false;
    protectKernelImage = true;
  };

  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://cache.nixos.org/" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  # Hardware section
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
  };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };

    bluetooth.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 30;
  };
  
  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;
    blueman.enable = true;
    xserver.videoDrivers = [ "nvidia" ];

    # Tailscale
    tailscale.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    logind = {
      extraConfig = ''
        HandleLidSwitch=suspend
        HandleLidSwitchExternalPower=ignore
        IdleAction=ignore
        HoldoffTimeoutSec=30s
        InhibitDelayMaxSec=5s
      '';
    };
  
    # Use power-profiles-daemon for better power management
    power-profiles-daemon.enable = true;
  
    # Keep upower for battery monitoring
    upower.enable = true;
  
    # Enable sound.
    # services.pulseaudio.enable = true;
    # OR

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    
    # Run the graphical Display Manager and Window Manager
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd '${pkgs.niri}/bin/niri'";
          # command = "${pkgs.niri}/bin/niri"; # To directly go to niri without login screen
          user = "r3d";
        };
      };
    };
    ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.r3d = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  programs = {
    dconf.enable = true;
    firefox.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        alias cat="bat --paging=never"
      '';
    };
    seahorse.enable = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    # foot
    # fuzzel
    # mako
    # wl-clipboard
    xdg-utils
    unzip
    # zellij
    # swaybg
    # grim
    # slurp
    # home-manager
    # niri # It will be available systemwide so you can start it from a TTY
    bibata-cursors
    xdg-desktop-portal
    xdg-desktop-portal-wlr
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.noto-fonts
      pkgs.inter
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };

  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  

  


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
  system = {
    stateVersion = "25.05"; # Did you read the comment?
    
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-25.05";
    };
  };
}


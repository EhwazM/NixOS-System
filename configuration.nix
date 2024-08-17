# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

     nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.shells = with pkgs; [zsh bash];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

   networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "America/Bogota";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    services.xserver.enable = true;
    services.xserver.excludePackages = with pkgs; [
        xterm
    ];


  

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.ehwazm = {
   isNormalUser = true;
   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     firefox
   ];
 };

 # List packages installed in system profile. To search, run:
 # $ nix search wget
 environment.systemPackages = with pkgs; [
    alacritty
    alsa-utils
    ark
    ark
    btop
    calc
    calcure
    cargo
    cliphist
    curl
    dunst
    fastfetch
    git
    github-desktop
    gnome.gnome-keyring
    go
    grim
    grim
    heroic
    hyprpaper
    jq
    julia
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kservice
    kdePackages.okular
    kdePackages.qtstyleplugin-kvantum        
    kdePackages.qtsvg # Dolphin icons
    kdePackages.qtwayland
    kitty
    links2
    lxde.lxsession
    neovim
    networkmanagerapplet
    nwg-displays
    pavucontrol
    python3
    ranger
    rofi-wayland
    sane-airscan
    sddm
    simple-scan
    slurp
    sshfs
    swaylock
    tree
    udiskie
    unrar-free
    unzip
    vlc
    vscode
    waybar
    wget
    wine
    wl-clipboard
    wlogout
    xdg-desktop-portal-gtk
    xdg-user-dirs
    xdg-utils
    xorg.libX11
    xorg.xorgproto
    zip
 ];

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
    

    services.blueman.enable = true;

    security.polkit.enable = true;


    fonts.packages = with pkgs; [
        corefonts
        google-fonts
        nerdfonts
        font-awesome
    ];

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; 
        dedicatedServer.openFirewall = true;

        extraCompatPackages = with pkgs; [
            proton-ge-bin
        ];

        gamescopeSession = {
            enable = true;
        };
    };

    services.gnome.gnome-keyring.enable = true;

    security.pam.services.sddm.enableGnomeKeyring = true;

    xdg = {
        mime.enable = true;
        menus.enable = true;
    };

    services.gvfs.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}


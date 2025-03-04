# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
  ################
  # CHAGE LABEL! #
  ################
  # =======================
  system.nixos.label = "VideoDownloader";
  # =======================

  imports =
    [ # Include the results of the hardware scan.
      ./nixos/hardware-configuration.nix
      ./pkgs/pkgs.nix
      ./pkgs/gpu-cpu.nix # DESHABILITALO si no usas CPU AMD y RADEON GRAPHICS
      ./pkgs/theme.nix
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # == ESENTIAL CONFIGURATION ====================================

  # BOOT =-----------------------------=

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # NETWORK =--------------------------=

  networking.networkmanager.enable = true;
  networking.hostName = "dash"; # hostname.

  time.timeZone = "America/Mexico_City";

  # DESKTOP =---------------------------=

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  # Interacciones de escritorio
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # SOUND =-----------------------------=

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # USERS =----------------------------=

  users.users.axolt = {
    isNormalUser = true;
    description = "Axolotl principal";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
    home = "/home/axolt";
  };  

  # SUDO =------------------------------=

  security.sudo.enable = true;

  
  # == APPS CONFIGURATION ========================================

  # File manager PCMANFM autoMounting
  services.gvfs.enable = true;

  # TouchScreen
  services.libinput.enable = true;
  
  # Cup (Prints screens)
  services.printing.enable = true;
  
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    # Steam
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/axolt/.steam/root/compatibilitytools.d";
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      experimental = true; # show battery

      # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
      # for pairing bluetooth controller
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = true;
    };
  };
  services.blueman.enable = true; 
  hardware.xpadneo.enable = true; # Enable the xpadneo driver for Xbox One wireless controllers

  # Botting
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
    # connect xbox controller
  };

  # nix-ld (For gcup for haskell)
  # programs.nix-ld.enable = true;

  # PROGRAMS =--------------------------=
  environment.systemPackages = with pkgs; [
  ];

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

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
  
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Set your time zone.

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
  # services.xserver.enable = true;
  system.stateVersion = "24.11"; # Did you read the comment?

}


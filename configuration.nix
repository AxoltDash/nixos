# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
    ################
    # CHAGE LABEL! #
    ################
    # =======================
    system.nixos.label = "wakeonlan";
    # =======================

    imports =
        [ # Include the results of the hardware scan.
            ./nixos/hardware-configuration.nix # ASEGURATE DE COPIAR TU PROPIO ARCHIVO DE /etc/nixos/hardware-configuration.nix
            ./pkgs/pkgs.nix
            ./pkgs/hardware.nix # CREA UN ARCHIVO DE HARWARE, EN ESTE DEBES DE COLOCAR LOS DRIVERS EXCLUSIVOS DE TU PC Y EL NAME DEL DISPOSITIVO CON HOSTNAME
            ./pkgs/languages.nix
        ];
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    # == ESENTIAL CONFIGURATION ====================================

    # BOOT =-----------------------------=

    boot.loader.systemd-boot.enable = true;
    boot.loader.timeout = 1;
    boot.loader.efi.canTouchEfiVariables = true;
    
    services.displayManager.ly.enable = true;

    # NETWORK =--------------------------=

    networking.networkmanager.enable = true;

    time.timeZone = "America/Mexico_City";

	networking.firewall = {
		enable = true;
		allowedTCPPorts = [ 80 443 8008 8009 443 7770 8443 ];
		allowedUDPPorts = [ 1900 5353 80 51820 4569 1194 5060 ];
		allowedUDPPortRanges = [
			{ from = 1; to = 65535; }
		];
		checkReversePath = false;
	};

    # DESKTOP =---------------------------=

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    
    # Interacciones de escritorio
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	# Forzar Wayland
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
        extraGroups = [ "wheel" "networkmanager" "dialout" "uucp" "plugdev" ];
        shell = pkgs.zsh;
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
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/axolt/.steam/root/compatibilitytools.d";
    };

    # Fonts 
    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.roboto-mono
		monocraft
    ];


    # USB Arduino
    services.udev.extraRules = ''
        # Permisos para dispositivos seriales (Arduino, ESP, etc.)
        KERNEL=="ttyUSB[0-9]*", MODE="0666"
        KERNEL=="ttyACM[0-9]*", MODE="0666"
    '';

    # Flatpak
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
    };

	# Enable ZSH
	programs.zsh.enable = true;

    # Deleting NixOS generations
    boot.postBootCommands = ''
    # Configura el PATH completo de NixOS
    export PATH=/run/current-system/sw/bin:/run/current-system/sw/sbin:$PATH
    
    # Ejecuta el script con logging
    echo "Ejecutando trim-generations.sh..." >&2
    /run/current-system/sw/bin/bash /home/axolt/nixos/scripts/trim-generations.sh 15 30 system 2>&1 | tee -a /var/log/trim-generations.log || {
      echo "Error en trim-generations.sh. Ver /var/log/trim-generations.log" >&2
    }
    '' ;

	# Gnome Keyring
	services.gnome.gnome-keyring.enable = true;

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

    system.stateVersion = "25.05"; # Did you read the comment?

}

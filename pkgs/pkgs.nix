{ config, pkgs, lib, ... }:

{
  # PROGRAMS ====================================
  environment.systemPackages = with pkgs; [
    # ESTENTIALS =------------------------------=
    git
    wget
    curl
    zsh
    vim
    nano
    fastfetch
    tree
    btop 
    home-manager
    

    # DESKTOP =---------------------------------=
    waybar
    hyprpaper
    rofi-wayland
    wl-clipboard
    brightnessctl
    hyprshade

    # Notifications
    dunst
    libnotify

    # Audio
    pulseaudio
    
    # Screen
    grim
    slurp

    # Recording
    obs-studio
    obs-studio-plugins.obs-vaapi
    gst_all_1.gst-vaapi

    # CODING =----------------------------------=
    neovim
    nano
    lazygit
    gh # github cli
    vscode

    # APPS =------------------------------------=
    # Terminal
    kitty

    # Browsers
    firefox
    brave

    # Files
	xfce.thunar
    zathura
    libreoffice
	vlc
    
    # Utilities
    qalculate-gtk
    obsidian
    
    # Metting
    discord
    telegram-desktop
    zoom-us

    # Desing
    kdePackages.kdenlive
    gimp
    inkscape
    krita

    # Etc
    arduino-ide
	gnome-clocks

    # TERMINAL =--------------------------------=
    ranger
    peaclock

    # IMAGES & VIDEOS =-------------------------=
    ytdownloader
    nsxiv

    # GAMING =----------------------------------=
    mangohud
    protonup
    steam
    steam-run
    steam-unwrapped
    lutris
    dolphin-emu

    # GAMES =-----------------------------------=
    _2048-in-terminal
    prismlauncher
    
    # SERVICES =--------------------------------=
    zip
    unzip
    lynx
    
    # Bluethooth
    bluez
    bluez-tools
    blueman

    # SCHOOL =----------------------------------=
    # Creacion de hardware
    logisim-evolution

    # MISC =------------------------------------=
    cava
    cbonsai
    activate-linux
    cmatrix

    #EXTRA =------------------------------------=
    ripgrep # searching with a moddern grep for telescope
    fd # searching tool for telescope
    tree-sitter # Parser generator
    gnumake # manage non-source files to source
    xz # compression tool
  ];
  nixpkgs.config.allowUnfree = true;
}

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
    
    # Notifications
    dunst
    libnotify

    # Audio
    pulseaudio
    
    # Screen
    grim
    slurp
    
    # CODING =----------------------------------=
    neovim
    nano
    lazygit
    gh # github cli
    vscode

    # APPS =------------------------------------=
    kitty
    firefox
    pcmanfm
    discord
    obsidian
    telegram-desktop
    libreoffice

    # TERMINAL =--------------------------------=
    ranger

    # IMAGES & VIDEOS =-------------------------=
    ytdownloader
    nsxiv

    # GAMING =----------------------------------=
    mangohud
    protonup
    steam
    steam-run
    steam-unwrapped

    # GAMES =-----------------------------------=
    _2048-in-terminal
    dwarf-fortress
    
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

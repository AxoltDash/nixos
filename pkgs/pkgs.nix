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

    # LANGUAGES 
    # Haskell
    ghc
    cabal-install
    # Python
    python3
    # C 
    gcc
    # Rust
    cargo
    rust-analyzer
    rustc
    # JavaScript
    nodejs
    # Java
    jdk
    # Go
    go
    # PHP
    php
    phpPackages.composer
    # Julia
    julia

    #Extra
    luarocks # neovim plugins
    lua
    lua-language-server

    #Extra
    ripgrep # searching with a moddern grep for telescope
    fd # searching tool for telescope
    tree-sitter # Parser generator
    gnumake # manage non-source files to source
    xz # compression tool
    #coreutils # basic file, shell and text manipulation
    #ncurses # library for text-based user interfaces
    #gmp # library for arbitrary precision arithmetic
    #pkg-config # manage compile and link flags for libraries

    # APPS =------------------------------------=
    kitty
    firefox
    pcmanfm
    nsxiv
    ranger
    discord
    obsidian

    # GAMING =----------------------------------=
    mangohud
    protonup
    steam
    steam-run
    steam-unwrapped

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
  ];
  nixpkgs.config.allowUnfree = true;
}

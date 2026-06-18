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
    rofi
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
	tesseract

    # Recording
    obs-studio
    obs-studio-plugins.obs-vaapi
    gst_all_1.gst-vaapi

    # CODING =----------------------------------=
    # neovim
	(neovim.override { withPython3 = true; })
	(python3.withPackages (ps: [ ps.pynvim ]))
    nano
    gh # github cli
    vscode

    # APPS =------------------------------------=
    # Terminal
    kitty
	cool-retro-term
    lazygit
	impala
	bluetui
	claude-code

    # Browsers
    brave
	# firefox

    # Files
	nautilus
    zathura
    libreoffice
	vlc
	kdePackages.okular
    
    # Utilities
    qalculate-gtk
    obsidian
    anki

    # Metting
    discord
    telegram-desktop
    zoom-us

    # Desing
    kdePackages.kdenlive
    inkscape
    krita

    # Etc
	gnome-clocks

    # TERMINAL =--------------------------------=
    peaclock
	(yazi.override {
	 _7zz = _7zz-rar;  # Support for RAR extraction
	 })

    # IMAGES & VIDEOS =-------------------------=
    ytdownloader
    nsxiv

    # GAMING =----------------------------------=
    mangohud
    protonup-ng
    steam
    steam-run
    steam-unwrapped
		# dolphin-emu

    # GAMES =-----------------------------------=
    _2048-in-terminal
    prismlauncher
	tetris
    
    # SERVICES =--------------------------------=
    zip
    unzip
    lynx
    
    # Bluethooth
    bluez
    bluez-tools
    blueman

    # SCHOOL =----------------------------------=
	dbeaver-bin

	# PROTON =----------------------------------=
	# protonvpn
	mpi

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
	wireguard-tools #VPN

	# yazi extras:
	ffmpeg
	jq
	poppler
	fzf
	zoxide
	resvg
	imagemagick
  ];
  nixpkgs.config.allowUnfree = true;
}

{ system, inputs, config, options, lib, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "axolt";
    home.homeDirectory = "/home/axolt";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
		zsh-powerlevel10k	#pwl10k
		xrdb				#xorg themes resources

		# inputs.zen-browser.packages."${system}".default

        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/axolt/etc/profile.d/hm-session-vars.sh
    #

	# SESSION VARIABLES =--------------------------------------
    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };

	xdg.mimeApps = {
		enable = true;
		associations.added = {
			"x-scheme-handler/tg" = "org.telegram.desktop.desktop;";
			"x-scheme-handler/tonsite" = "org.telegram.desktop.desktop;";
		};
		defaultApplications = {
			# ZEN BROWSER =---=
			"text/html" = "app.zen_browser.zen.desktop";
			"x-scheme-handler/http" = "app.zen_browser.zen.desktop";
			"x-scheme-handler/https" = "app.zen_browser.zen.desktop";
			"x-scheme-handler/about" = "app.zen_browser.zen.desktop";
			"x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";
			"x-scheme-handler/chrome" = "app.zen_browser.zen.desktop";
			"application/x-extension-htm" = "app.zen_browser.zen.desktop";
			"application/x-extension-html" = "app.zen_browser.zen.desktop";
			"application/x-extension-shtml" = "app.zen_browser.zen.desktop";
			"application/x-extension-xhtml" = "app.zen_browser.zen.desktop";
			"application/x-extension-xht" = "app.zen_browser.zen.desktop";
			"application/xhtml+xml" = "app.zen_browser.zen.desktop"; 

			# DISCORD =---=
			"x-scheme-handler/discord-455712169795780630" = "discord-455712169795780630.desktop";

			# PCMANFM =---=
			#"inode/directory" = "thunar.desktop";
			"inode/directory" = "org.gnome.Nautilus.desktop";
			
			# NXSIV =---=
			"image/png"="nsxiv.desktop";
			"image/jpeg"="nsxiv.desktop";
			"image/webp"="nsxiv.desktop";
			"image/bmp"="nsxiv.desktop";
			"image/svg+xml"="nsxiv.desktop";

			# PDF ZARTHURA =---=
			"application/pdf"="org.pwmt.zathura.desktop";
		};
	};

	# programs.brave = {
	# 	enable = true;
	# 	package = pkgs.writeShellScriptBin "brave" ''
	# 		exec ${pkgs.brave}/bin/brave \
	# 			--ozone-platform=wayland \
	# 			--enable-features=UseOzonePlatform \
	# 			"$@"
	# 	'';
	# };

	# ZSH =-------------------------------------------------=
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		defaultKeymap = "emacs";
		# oh-my-zsh = {
		# 	enable = true;
		# 	plugins = [
		# 		"extract"
		# 		"colored-man-pages"
		# 	];
		# };

		initContent = ''

			# Powerlevel10k lazy load
			if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
				source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
			fi
			source ~/.p10k.zsh
			zstyle ':completion:*' matcher-list 'r:|=l'
			export PATH="$HOME/.cargo/bin:$PATH"


      # teclas para q funke ctrl + izq y ctr + delete
			[[ -r /etc/zinputrc ]] && source /etc/zinputrc
			bindkey '^[[1;5D' backward-word
			bindkey '^[[1;5C' forward-word
			bindkey '^H' backward-kill-word
			bindkey '^[[3;5~' kill-word


			function y() {
				local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
					command yazi "$@" --cwd-file="$tmp"
					IFS= read -r -d "" cwd < "$tmp"
					[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
					command rm -f -- "$tmp"
			}
		''; 
	
		plugins = [
			{
				name = "powerlevel10k";
				src = pkgs.zsh-powerlevel10k;
				file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
			}
		];

		shellAliases = {
			update = "sudo nixos-rebuild switch --flake ~/nixos";
			update-flake = "nix flake update --flake ~/nixos";
      update-gc = "nix-env --delete-generations old --profile /home/axolt/.local/state/nix/profiles/home-manager && nix-env --delete-generations old --profile /home/axolt/.local/state/nix/profiles/profile && sudo sh -c 'nix-env --delete-generations old --profile /nix/var/nix/profiles/system && nix-collect-garbage -d'";
		};
	};

	# GIT =-------------------------------------------------=
    programs.git = {
        enable = true;
        settings = {
            init.defaultBranch = "main";
			user.name = "AxoltDash";
			user.email = "darshan@ciencias.unam.mx";
		};
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };

        "sia" = {
          hostname = "10.10.220.248";
          user = "darsh";
          port = 1408;
          identityFile = "~/.ssh/ifc-server";
          identitiesOnly = true;
          IPQoS = "none";
          ObscureKeystrokeTiming = "no";
        };
      };
    };

    # THEMES =------------------------------------------------=
    gtk = {
        enable = true;
        theme = {
            package = pkgs.gruvbox-gtk-theme;
            name = "Gruvbox-Dark";
        };
		gtk4 = {
			theme = {
				package = pkgs.gruvbox-gtk-theme;
				name = "Gruvbox-Dark";
			};
		};
		iconTheme = {
            package = pkgs.gruvbox-material-gtk-theme;
            name = "Gruvbox-Material-Dark"; 
        };

    };

    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
        style.package = pkgs.adwaita-qt;
    };

    home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 12;
        hyprcursor = {
            enable = true;
            size = 12;
        };
        x11.enable = true;
        gtk.enable = true;
    };

    xresources.properties = {
      "Nsxiv.window.background" = "#121110";
      "Nsxiv.window.foreground" = "#f2e5bc";
      "Nsxiv.bar.background" = "#222222";
      "Nsxiv.bar.foreground" = "#f2e5bc";
      "Nsxiv.mark.foreground" = "#c9a554";
    };

	# HOME MANAGER =------------------------------------------
    
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

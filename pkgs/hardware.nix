{ inputs, config, lib, pkgs, ... }:

{
	# VIDEO DRIVERS =-------------------------=

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
    environment.systemPackages = with pkgs; [
        mesa  # Drivers OpenGL/Vulkan
        mesa.opencl
        mesa-demos  # OpenGL
        vulkan-tools  # Vulkan
        vulkan-validation-layers
    ];
    services.xserver.videoDrivers = [ "amdgpu" ];


    # POWER MANAGEMENT =---------------------------=

    powerManagement.enable = true;
	services.tlp = {
		enable = true;
		settings = {
			# Disbale power management for WiFi
			WIFI_PWR_ON_AC = "off";
			WIFI_PWR_ON_BAT = "off";
			# Disable power management for PCIe (only my for my laptop)
			RUNTIME_PM_ON_AC = "auto";
			RUNTIME_PM_ON_BAT = "auto";
			# Exclude WiFi Hardware from power management
			RUNTIME_PM_DRIVER_DENYLIST = "rtw88_8821ce rtw_8821ce";
		};
	};

	services.upower = {
		enable = true;
		percentageLow = 15;
		percentageCritical = 8;
		percentageAction = 3;
		criticalPowerAction = "PowerOff";  # Solo apagar cuando llegue a 5%
	};


    # BLUETOOTH =-------------------------=

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General = {
            Privacy = "device";
            JustWorksRepairing = "always";
            FastConnectable = true;
			ControllerMode = "dual";
        };
    };
    services.blueman.enable = true; 
    hardware.xpadneo.enable = true; # Enable the xpadneo driver for Xbox One wireless controller


    # SOUND =-----------------------------=

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
		wireplumber.enable = true;
		# config for better audio quality
		wireplumber.extraConfig.bluetoothEnhancements = {
			"monitor.bluez.properties" = {
				"bluez5.enable-sbc-xq" = true;
				"bluez5.enable-hw-volume" = true;
				"bluez5.enable-ldac" = true;
				"bluez5.enable-aac" = true;
				"bluez5.headset-roles" = [ ];
				"bluez5.autoswitch-profile" = false;
			};
		};
		wireplumber.extraConfig.forceA2DP = {
			"monitor.bluez.rules" = [
			{
				matches = [
				{ "device.name" = "~bluez_card.*"; }
				];
				actions = {
					update-props = {
						"bluez5.auto-connect" = [ "a2dp_sink" ];
					};
				};
			}
			];
		};
    };


    # NETWORK =--------------------------=

    networking.networkmanager.enable = true;
	networking.networkmanager.wifi.powersave = false;

    time.timeZone = "America/Mexico_City";

	networking.firewall = {
		enable = true;
		trustedInterfaces = [ "wlp2s0" ]; # Confía en todo el tráfico local WiFi
		allowedUDPPorts = [ 51820 ]; # Solo WireGuard, que sí necesita estar abierto externamente
		checkReversePath = false;
	};
	# networking.firewall = {
	# 	enable = true;
	# 	allowedTCPPorts = [ 80 443 8008 8009 443 7770 8443 ];
	# 	allowedUDPPorts = [ 1900 5353 80 51820 4569 1194 5060 ];
	# 	allowedUDPPortRanges = [
	# 		{ from = 1; to = 65535; }
	# 	];
	# 	checkReversePath = false;
	# };
	systemd.services.NetworkManager-wait-online.enable = false;


    # BOTTING =--------------------------=

    boot = {
        extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
        extraModprobeConfig = ''
            options bluetooth disable_ertm=Y
			options rtw88_8821ce disable_msi=1
			options rtw_8821ce ant_sel=2
        '';
        # connect xbox controller
    };
    

    #NAME OF THE SYSTEM
    networking.hostName = "dash"; # hostname.
}
